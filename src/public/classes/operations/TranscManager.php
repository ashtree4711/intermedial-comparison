<?php
namespace App\operations;
use App\models\StandoffProperty;
use App\models\TranscriptionPage;
use App\models\Work;

class TranscManager
{
   public static function getStyledTranscription($transcId, $text, $charIndex=0, $lastChar=-1, $chunks=true){
       ///TEST AREA
       //error_log("charIndex: ".$charIndex);
       //error_log("lastChar: ".$lastChar);
       if ($chunks==true){
           $properties = StandoffProperty::where("transc_page_id", "=", $transcId)->with("text_property")->get()
               ->sortBy(function($property) {
                   return $property->text_property->index;
               })->toArray();
       } else {
           $properties = StandoffProperty::where("transc_page_id", "=", $transcId)->where("property_name", "!=", "chunk")->with("text_property")->get()
               ->sortBy(function($property) {
                   return $property->text_property->index;
               })->toArray();
       }

       $fragments=array();
       $fragmentIndex=0;
       $i=0;
       if ($properties==null){
           $fragments[0]["text"]=substr($text, $charIndex, $lastChar-$charIndex);
       }

       foreach ($properties as $property){
           $index=$property["text_property"]["index"];
           $length=$property["text_property"]["length"];

           $endIndex=$index+$length;
           $fragments[$fragmentIndex]["properties"]=array();
           //error_log($property["id"].": ".$index."|".$len;gth."|".$endIndex."|");
           //error_log("CHARINDEX: ".$charIndex);

           if ($lastChar!=-1 && $charIndex>=$lastChar){
               break;
           }

           # Wenn der Eigenschafts-Index größer als die aktuelle Zeihenindex ist, wird ein Fragment ohne Eigenschaft
           # angelegt.
           if ($charIndex < $index){
               $fragments[$fragmentIndex]["text"]=substr($text, $charIndex, $index-$charIndex);
               $fragmentIndex++;
           }
           # Wenn der Zeichenindex größer als der Eigenschaft-Index ist, liegt die Eigenschaft im Bereich einer anderen
           # Eigenschaft. Der bereits bearbeitete Bereich hat daher ein eigenes Fragment, sodass die Parameter angepasst
           # werden müssen, um für die restliche Eigenschaft ein eigenes Fragment zu erzeugen.
           if ($charIndex>$index){
               $delta=$charIndex-$index;
               $index=$charIndex;
               $length=$length-$delta;
               //error_log("Parts of Property already rendered before. CUT INDEX & LENGTH to ".$index."|".$length);
           }
           if ($charIndex<$endIndex){
               $fragments[$fragmentIndex]["text"]=substr($text, $index, $length);
               //error_log($fragments[$fragmentIndex]["text"]);
               $fragments[$fragmentIndex]["properties"]=array();
               array_push( $fragments[$fragmentIndex]["properties"], $property);
               $charIndex=$endIndex;
           }


           //SCENARIOS
           foreach ($properties as $property2){
               if ($property["id"]!=$property2["id"]){
                   $index2=$property2["text_property"]["index"];
                   $length2=$property2["text_property"]["length"];
                   $endIndex2=$index2+$length2;

                   if ($index2>=$index){
                       //error_log("Found Property within Property ".$property["id"]." (".$index."|".$endIndex.") => ".$property2["id"]." (".$index2."|".$endIndex2.")");
                       /// AP HAS SAME INDEX AND SAME ENDINDEX => ANOTHER PROPERTY TO SAME FRAGMENT
                       if ($index2==$index && $endIndex2>=$endIndex){
                           //error_log("CASE 1: Second Property has same index and same length or longer.");
                           //$fragments[$fragmentIndex]["property_name"]=array();
                           //$fragments[$fragmentIndex]["properties"]=array();
                           array_push( $fragments[$fragmentIndex]["properties"], $property2);
                       }
                       /// AP HAS SAME INDEX BUT NOT SAME ENDINDEX => SPLIT FRAGMENT INTO TWO -> FIRST WITH TWO PROP, SECOND WITH ONE PROP
                       if ($index2==$index && $endIndex2<$endIndex){
                           //error_log("CASE 2: Second Property has same index and length is shorter.");
                           $fragments[$fragmentIndex]["text"]=substr($text, $index, $length2);
                           array_push( $fragments[$fragmentIndex]["properties"], $property2);
                           $fragmentIndex++;
                           $fragments[$fragmentIndex]["text"]=substr($text, $endIndex2, $length-$length2);
                           //$fragments[$fragmentIndex]["property_name"]=array();
                           //$fragments[$fragmentIndex]["properties"]=array();
                           array_push( $fragments[$fragmentIndex]["properties"], $property);
                       }
                       /// AP HAS NOT SAME INDEX BUT SAME ENDINDEX => SPLIT FRAGMENT INTO TWO -> FIRST WITH ONE PROP, SECOND WITH TO
                       if ($index2>$index && $endIndex2==$endIndex){
                           //error_log("CASE 3: Second Property has larger index and end index is same or larger.");
                           $fragments[$fragmentIndex]["text"]=substr($text, $index, $index2-$index);
                           //error_log($fragments[$fragmentIndex]["text"]);
                           $fragmentIndex++;
                           $fragments[$fragmentIndex]["text"]=substr($text, $index2, $length2);
                           //error_log($fragments[$fragmentIndex]["text"]);
                           //$fragments[$fragmentIndex]["property_name"]=array();
                           //$fragments[$fragmentIndex]["properties"]=array();
                           array_push( $fragments[$fragmentIndex]["properties"], $property);
                           array_push( $fragments[$fragmentIndex]["properties"], $property2);
                       }
                       //ANOTHER PROPERTY IS WITHIN (BETWEEN INDEX AND ENDINDEX)
                       if ($index2>$index && $endIndex2<$endIndex){
                           //error_log("CASE 4: Second Property has larger index and end index shorter. We get 3 fragments");
                           $fragments[$fragmentIndex]["text"]=substr($text, $index, $index2-$index);
                           //error_log($fragments[$fragmentIndex]["text"]);
                           $fragmentIndex++;
                           $fragments[$fragmentIndex]["text"]=substr($text, $index2, $length2);
                           //error_log($fragments[$fragmentIndex]["text"]);
                           //$fragments[$fragmentIndex]["property_name"]=array();
                           $fragments[$fragmentIndex]["properties"]=array();
                           array_push( $fragments[$fragmentIndex]["properties"], $property);
                           array_push( $fragments[$fragmentIndex]["properties"], $property2);
                           $fragmentIndex++;
                           $fragments[$fragmentIndex]["text"]=substr($text, $endIndex2, $endIndex-$endIndex2);
                           //error_log($fragments[$fragmentIndex]["text"]);
                           //$fragments[$fragmentIndex]["property_name"]=array();
                           $fragments[$fragmentIndex]["properties"]=array();
                           array_push( $fragments[$fragmentIndex]["properties"], $property);
                       }


                   }
               }
           }
           /// AP HAS NOT SAME INDEX AND NOT SAME ENDINDEX => SPLITFRAGMENT INTO TWO -> FIRST ONE PROP, SND TWO PRO, LAST ONE PROP
           //ANOTHER PROPERTY WILL OVERLAPSE => BASICILLY THE SAME BUT NEXT PROP HAS TO TAKE INTO ACCOUNT THAT INDEX IS CHARINDEX!
           if ($lastChar!=-1 && $charIndex>=$lastChar){
               break;
           }
           if (++$i===count($properties)){
               $fragmentIndex++;
               $fragments[$fragmentIndex]["text"]=substr($text, $charIndex, $lastChar-$endIndex);
               //error_log(print_r($fragments[$fragmentIndex]["text"], true));
           } else {
               $fragmentIndex++;
           }

       }
      //error_log(print_r($fragments, true));
       $data["fragments"]=$fragments;
       return $fragments;
   }


   public static function generateTranscFragmentsPerPage($transc_page_id){
        $page = TranscriptionPage::where("id", "=", $transc_page_id)->with("plaintext")
            ->first()
            ->toArray();
        $endIndex=strlen($page["plaintext"]["content"]);
        $fragments=TranscManager::generateFragments(0, $endIndex, $transc_page_id, $page["plaintext"]["content"], true);
        return $fragments;
   }

    public static function generateTranscFragmentsPerChunk($property){
        $page = TranscriptionPage::where("id", "=", $property["transc_page_id"])->with("plaintext")
            ->first()
            ->toArray();
        $fragments=TranscManager::generateFragments($property["text_property"]["index"], $property["text_property"]["length"], $property["transc_page_id"], $page["plaintext"]["content"], false);
        return $fragments;
    }





   private static function generateFragments($startIndex, $length, $transc_page_id, $text, $chunks=true){
        //error_log(print_r($property, true));
        $fragments=array();
        $fragmentsIndex=0;
        $endIndex=$startIndex+$length;
        $lastChar=$endIndex-1;
        $text=substr($text, $startIndex, $length);
        $textArray=str_split($text);
        $chars=array();
        for ($i=0; $i<count($textArray); $i++){
            $chars[$i+$startIndex]=$textArray[$i];
        }

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
        //error_log(print_r($thirdProperties, true));

        return $fragments;
    }

   public static function generateTranscFragmentsPerChunk2($property){
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
       //error_log(print_r($thirdProperties, true));

       return $fragments;
   }

}