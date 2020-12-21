<?php
namespace App\operations;
use App\models\StandoffProperty;
use App\models\TranscriptionPage;

class TranscManager
{

    /**
     * Holt anhand der übergebenen Transcription Page Id die Transkriptionsseite mitsamt Plaintext und übergibt die Daten
     * an die Fragment-Erstellung
     * @param $transc_page_id
     * @return array
     */
   public static function generateTranscFragmentsPerPage($transc_page_id){
        $page = TranscriptionPage::where("id", "=", $transc_page_id)->with("plaintext")
            ->first()
            ->toArray();
        $endIndex=strlen($page["plaintext"]["content"]);
        $fragments=TranscManager::generateFragments(0, $endIndex, $transc_page_id, $page["plaintext"]["content"], true);
        return $fragments;
   }

    /**
     * Erstellt Textfragmente, welche im gleichen Zeichenbereich die gleichen Eigenschaften teilen. Zurückgegeben wird
     * ein Array mit Fragmenten, welche sowohl den Text-String als auch ein Array aller Eigenschaften beinhalten.
     *
     * @param $startIndex
     * @param $length
     * @param $transc_page_id
     * @param $text
     * @param bool $chunks
     * @return array
     */
   private static function generateFragments($startIndex, $length, $transc_page_id, $text, $chunks=true){
       # Ininitialisiere Variablen
       $fragments = array();
       $fragmentsIndex = 0;
       $endIndex = $startIndex + $length;
       $lastChar = $endIndex - 1;
       $text = substr($text, $startIndex, $length);
       # Erstelle aus dem zu bearbeitenden String ein Array aus Zeichen
       $textArray = str_split($text);
       $chars = array();
       # Passe die Array-Indizes an die tatsächliche Position im Gesamttext einer Seite an
       for ($i = 0; $i < count($textArray); $i++) {
           $chars[$i+$startIndex]=$textArray[$i];
       }
       # Wenn $chunk==true, beziehe Chunk-Properties in die Generierung mit ein.
       # Hole alle Properties, deren Start-Index im untersuchten Bereich liegt.
       if ($chunks){
           $thirdProperties = StandoffProperty::with('text_property')
               ->where("transc_page_id", "=", $transc_page_id)
               ->whereHas('text_property', function($tp) use ($startIndex, $endIndex){
                   $tp->where('index', '>=', $startIndex);
                   $tp->where('index', '<', $endIndex);
               })->get()->sortBy(function($property) {
                   return $property->text_property->index;})
               ->toArray();
       } else {
           $thirdProperties = StandoffProperty::with('text_property')
               ->where('property_name', "!=", "chunk")
               ->where("transc_page_id", "=", $transc_page_id)
               ->whereHas('text_property', function($tp) use ($startIndex, $endIndex){
                   $tp->where('index', '>=', $startIndex);
                   $tp->where('index', '<', $endIndex);
               })->get()->sortBy(function($property) {
                    return $property->text_property->index;})
               ->toArray();
       }
       # Initilisiere Variablen für den nächsten Schritt
       $lastProperties=array();
       $fragmentText="";
       # Iteriere über jedes Zeichen des ausgewählten Textbereichs
       for ($i=$startIndex; $i<$endIndex; $i++){
           error_log("INVESTIGATE CHAR: ".$chars[$i]." (index: ".$i.")");
           $currentProperties=array();
           # Iteriere über Properties und ermittle, ob der aktuelle Zeichenindex im Bereich der jeweiligen Property
           # liegt. Wenn ja, lege die Property in ein lokales Array für das aktuelle Zeichen.
           for ($j=0; $j<count($thirdProperties); $j++){
               $tpStartIndex=$thirdProperties[$j]["text_property"]["index"];
               $tpLength=$thirdProperties[$j]["text_property"]["length"];
               $tpEndIndex=$tpStartIndex+$tpLength;
               if ($i >= $tpStartIndex && $i <=$tpEndIndex){
                   error_log("FOUND PROPERTY: ".$thirdProperties[$j]["property_name"]);
                   array_push($currentProperties, $thirdProperties[$j]["property_name"]);
               }
           }
           # Prüfe ob das vorherige Zeichen die gleichen Properties besitzt wie das aktuelle. Wenn ja, setze das
           # aktuelle Zeichen an den aktuellen Fragmenten-String. Wenn nein, erstelle durch den aktuellen Fragmenten-
           # String und die zuvor festgestellten Properties ein neues Fragment und lege es in das Fragmenten-Array.
           # Beginne anschließenden ein neuen Fragmenten-String.
           if ($lastProperties==$currentProperties){
               error_log("KEEP PROPERTY");
               $fragmentText=$fragmentText.$chars[$i];
               error_log($i."|".$lastChar);
               if ($i==$lastChar){
                   error_log("LAST");
                   $fragments[$fragmentsIndex]["text"]=$fragmentText;
                   $fragments[$fragmentsIndex]["properties"]=$lastProperties;
                   $fragmentsIndex++;
               }
           } else {
               $fragments[$fragmentsIndex]["text"]=$fragmentText;
               $fragments[$fragmentsIndex]["properties"]=$lastProperties;
               error_log(print_r($fragments[$fragmentsIndex], true));
               $fragmentsIndex++;
               $fragmentText=$chars[$i];
               error_log("SWITCH FRAGMENT");
           }
           $lastProperties=$currentProperties;

       }
       error_log(print_r($fragments, true));
       return $fragments;
    }

    /**
     * Holt anhand der übergebenen Property die Transkriptionsseite mitsamt Plaintext und übergibt die Daten
     * an die Fragment-Erstellung
     * @param $property
     * @return array
     */
    public static function generateTranscFragmentsPerChunk($property)
    {
        $page = TranscriptionPage::where("id", "=", $property["transc_page_id"])->with("plaintext")
            ->first()
            ->toArray();
        $fragments = TranscManager::generateFragments($property["text_property"]["index"], $property["text_property"]["length"], $property["transc_page_id"], $page["plaintext"]["content"], false);
        return $fragments;
    }

    public static function generateTranscFragmentsPerChunk2($property)
    {
       //error_log(print_r($property, true));
       $fragments=array();
       $fragmentsIndex=0;
       $startIndex=$property["text_property"]["index"];
       $length=$property["text_property"]["length"];
       $endIndex=$startIndex+$length;
       $lastChar=$endIndex-1;
       $text=substr($property["transcription_page_with_text"]["plaintext"]["content"], $startIndex, $length);
       $textArray=str_split($text);
       $chars=array();
       for ($i=0; $i<count($textArray); $i++){
           $chars[$i+$startIndex]=$textArray[$i];
       }
       $thirdProperties = StandoffProperty::with('text_property')->where('property_name', "!=", "chunk")
           ->where("transc_page_id", "=", $property["transc_page_id"])
           ->whereHas('text_property', function($tp) use ($startIndex, $endIndex){
           $tp->where('index', '>=', $startIndex);
           $tp->where('index', '<', $endIndex);
       })->get()->sortBy(function($property) {
               return $property->text_property->index;})
                   ->toArray();

        $lastProperties=array();
        $fragmentText="";
       for ($i=$startIndex; $i<$endIndex; $i++){
           error_log("INVESTIGATE CHAR: ".$chars[$i]." (index: ".$i.")");
           $currentProperties=array();
           for ($j=0; $j<count($thirdProperties); $j++){
               $tpStartIndex=$thirdProperties[$j]["text_property"]["index"];
               $tpLength=$thirdProperties[$j]["text_property"]["length"];
               $tpEndIndex=$tpStartIndex+$tpLength;
               if ($i >= $tpStartIndex && $i <=$tpEndIndex){
                   error_log("FOUND PROPERTY: ".$thirdProperties[$j]["property_name"]);
                   array_push($currentProperties, $thirdProperties[$j]["property_name"]);
               }
           }
           if ($lastProperties==$currentProperties){
               error_log("KEEP PROPERTY");
               $fragmentText=$fragmentText.$chars[$i];
               error_log($i."|".$lastChar);
               if ($i==$lastChar){
                   error_log("LAST");
                   $fragments[$fragmentsIndex]["text"]=$fragmentText;
                   $fragments[$fragmentsIndex]["properties"]=$lastProperties;
                   $fragmentsIndex++;
               }
           } else {
               $fragments[$fragmentsIndex]["text"]=$fragmentText;
               $fragments[$fragmentsIndex]["properties"]=$lastProperties;
               error_log(print_r($fragments[$fragmentsIndex], true));
               $fragmentsIndex++;
               $fragmentText=$chars[$i];
               error_log("SWITCH FRAGMENT");
           }
           $lastProperties=$currentProperties;

       }
       return $fragments;
   }

}