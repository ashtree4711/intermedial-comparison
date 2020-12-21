-- MySQL dump 10.13  Distrib 8.0.19, for osx10.15 (x86_64)
--
-- Host: 127.0.0.1    Database: 
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!50606 SET @OLD_INNODB_STATS_AUTO_RECALC=@@INNODB_STATS_AUTO_RECALC */;
/*!50606 SET GLOBAL INNODB_STATS_AUTO_RECALC=OFF */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `ict`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ict` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;

USE `ict`;

--
-- Table structure for table `chunks`
--

DROP TABLE IF EXISTS `chunks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chunks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chunk_no` int(11) NOT NULL,
  `work_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `chunks_works_id_fk` (`work_id`),
  CONSTRAINT `chunks_works_id_fk` FOREIGN KEY (`work_id`) REFERENCES `works` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chunks`
--

LOCK TABLES `chunks` WRITE;
/*!40000 ALTER TABLE `chunks` DISABLE KEYS */;
INSERT INTO `chunks` (`id`, `chunk_no`, `work_id`) VALUES (1,20,1),(2,21,1),(3,29,2),(4,29,1);
/*!40000 ALTER TABLE `chunks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `repository` varchar(255) DEFAULT NULL,
  `idno` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` (`id`, `identifier`, `type`, `country`, `location`, `repository`, `idno`) VALUES (1,'M-FR-PAR-BNF-heb.884','ms','Frankreich','Paris','Bibliothèque nationale de France','heb.884'),(2,'M-FR-PAR-BNF-lat.15453','ms','Frankreich','Paris','Bibliothèque nationale de France','lat.15453'),(3,'M-GB-OXF-BOD-Bodl.Or.155','ms','Großbritannien','Oxford','Bodleian Library','Bodl.Or.155'),(4,'M-IT-FLR-BML-Leop.Med.Fesul.162','ms','Italien','Florenz','Biblioteca Medicea Laurenziana','Leop.Med.Fesul.162'),(5,'M-US-NYC-MOR-M.858','ms','Vereinigte Staaten','New York City','Morgan Library','M.858'),(6,'M-VA-VAT-BAV-Vat.lat.2076','ms','Vatikan','Vatikan-Stadt','Biblioteca Apostolica Vaticana','Vat.lat.2076'),(7,'M-ES-SVQ-BU-A.330.154','ms','Spanien','Sevilla','Biblioteca Universitaria','A 330.154'),(8,'M-FR-PAR-BNF-lat.16150','ms','Frankreich','Paris','Bibliothèque nationale de France','lat.16150'),(9,'M-FR-PAR-BNF-lat.17155','ms','Frankreich','Paris','Bibliothèque nationale de France','lat.17155');
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faksimile`
--

DROP TABLE IF EXISTS `faksimile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faksimile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faksimile`
--

LOCK TABLES `faksimile` WRITE;
/*!40000 ALTER TABLE `faksimile` DISABLE KEYS */;
INSERT INTO `faksimile` (`id`, `identifier`) VALUES (1,'M-FR-PAR-BNF-heb.884'),(2,'M-FR-PAR-BNF-lat.15453'),(3,'M-GB-OXF-BOD-Bodl.Or.155'),(4,'M-IT-FLR-BML-Leop.Med.Fesul.162'),(5,'M-US-NYC-MOR-M.858'),(6,'M-VA-VAT-BAV-Vat.lat.2076'),(7,'M-ES-SVQ-BU-A.330.154'),(8,'M-FR-PAR-BNF-lat.16150'),(9,'M-FR-PAR-BNF-lat.17155');
/*!40000 ALTER TABLE `faksimile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faksimile_pages`
--

DROP TABLE IF EXISTS `faksimile_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faksimile_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_link` varchar(1000) DEFAULT NULL,
  `faksimile_id` int(11) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `page_number` int(11) DEFAULT NULL,
  `page_folio` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `faksimile_pages_faksimile_id_fk` (`faksimile_id`),
  CONSTRAINT `faksimile_pages_faksimile_id_fk` FOREIGN KEY (`faksimile_id`) REFERENCES `faksimile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faksimile_pages`
--

LOCK TABLES `faksimile_pages` WRITE;
/*!40000 ALTER TABLE `faksimile_pages` DISABLE KEYS */;
INSERT INTO `faksimile_pages` (`id`, `image_link`, `faksimile_id`, `owner`, `page_number`, `page_folio`) VALUES (1,'https://bilderberg.uni-koeln.de/iipsrv/iipsrv.fcgi?IIIF=books/BOOK-DARE-M-FR-PAR-BNF-heb.884/pyratiff/BOOK-DARE-M-FR-PAR-BNF-heb.884-0027.tif/info.json',1,'Bilderberg',27,'11v'),(2,'https://bilderberg.uni-koeln.de/iipsrv/iipsrv.fcgi?IIIF=books/BOOK-DARE-M-FR-PAR-BNF-heb.884/pyratiff/BOOK-DARE-M-FR-PAR-BNF-heb.884-0028.tif/info.json',1,'Bilderberg',28,'12r'),(3,'https://bilderberg.uni-koeln.de/iipsrv/iipsrv.fcgi?IIIF=books/BOOK-DARE-M-ES-SVQ-BU-A.330.154/pyratiff/BOOK-DARE-M-ES-SVQ-BU-A.330.154-0029.tif/info.json',7,'Bilderberg',29,NULL),(4,'https://bilderberg.uni-koeln.de/iipsrv/iipsrv.fcgi?IIIF=books/BOOK-DARE-M-FR-PAR-BNF-lat.16150/pyratiff/BOOK-DARE-M-FR-PAR-BNF-lat.16150-0015.tif/info.json',8,'Bilderberg',15,'6r'),(5,'https://bilderberg.uni-koeln.de/iipsrv/iipsrv.fcgi?IIIF=books/BOOK-DARE-M-FR-PAR-BNF-lat.17155/pyratiff/BOOK-DARE-M-FR-PAR-BNF-lat.17155-0027.tif/info.json',9,'Bilderberg',27,'11v');
/*!40000 ALTER TABLE `faksimile_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plaintexts`
--

DROP TABLE IF EXISTS `plaintexts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plaintexts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plaintexts`
--

LOCK TABLES `plaintexts` WRITE;
/*!40000 ALTER TABLE `plaintexts` DISABLE KEYS */;
INSERT INTO `plaintexts` (`id`, `content`) VALUES (1,'שיאמר שם הנמצא ר\"ל שנחלקנו אל כל הענינים ונעיין באחד מהם אם יצדק על הנמצא מצד מה שהוא אחד באמת אם לא וכאשר אמר והלקח לחלק על כמה פנים יאמר האחד במספר ואמר שהוא יאמר על שלשה ענינים אחד מהם המתדבק והוא כאמרנו קו אחד ושטח אחד וגשם אחד.  והשני מה שלא חלק כמו הנקודה והשלישי על שמות אשר יורו על ענין אחד במהות וגדר וירצה במאמר המורה על מהותם הגדר. אמר ארסטו ואם היה לעולם מתדבק הנה הוא אחד ורבים וזה שהמתדבק יחלק אל מה שאין תכלית לו ובכאן מקום ספק בחלק והכל וראוי שלא יהיה נכנס בזה המאמר שהוא בעצמו עומד וזה הוא מי יתן ואדע אם החלק והכל דבר אחד או יותר מאחד וכל אי זה צד הוא אחד או יותר מאחד והחלקים גם כן הבלתי מתדבקים אם היה כל אחד מן הכל ואחד מהם דבר אחד מפני שהוא בלתי נבדל הנה כבר יחוייב שיהיה קצתם נאות לקצת  הפירוש  כאשר חלק הענינים אשר יאמר עליהם שם האחד לקח לעיין באחד אחד אם יצדק על המצא מצד שהוא אחד במוחלט ר\"ל בלתי רבים והוא אשר סתרו בו הקדמונים באמרם שהמצא אחד והתחיל מזה במתדבק כי המתדבק ממה שיאמר עליו שם האחד ואמר ואם היה לעולם מתדבק הנה הוא אחד והרבה וזה שהמתדבק יחלק אל מה שאין תכלית לו ירצה ואן רצה באמרם שהנמצא אחד שהוא מתדבר תמיד הנה כבר יחוייב עליהם שיורה שהוא אחד מצד ורבים מצד וזה שהמתדבק כבר אפשר בו החלק אל בלתי תכלית הנה יהיה הנמצא כפי זה איננו אחד באמת ולא בשלוח כי הוא מצד שיחלק יהיה רבים הנה הוא אחד בפעל רבים בכח ר\"ל בהחלק ולמה שהיה גם כן יקרה במתדבק ובכל מה שיש לו חלקים שלא יהיה הרבוי הנמצא בו מפני זולתיות החלקים קצתם לקצת אבל גם כן מפני זולתיות החלקים לכל לקח גם כן לדרוש זה הזולתיות בם ויגלגל בזה הספק הנופל בו לקדמונים ואמר   ובכאן מקום ספק בחלק והכל וראוי שלא יהיה נכנס בזה המאמר שהוא בעצמו עומד ירצה ובכאן מקום ספק בחלק והכל יש לו התלות בזה המאמר וראוי שלא יהיה הכנסו בזה המאמר והתלותו בו הכרחי ואם היה ספק עומד בעצמו ר\"ל ממה שיחוייב לחקור ממנו בעצמותו לא מפני התלותו בזה הדרוש וכאשר באר זאת הסיבה המביאה לדבר בזה הספק התחיל לזכור הפסק ואמר וזה הוא מי יתן ואדע אם החלק והכל אחד או יותר מאחד ועל אי זה צד הם אחד  ירצה וזה  הספק הוא האם הכל והחלק הוא דבר אחד או הם מתחלפים ואם היו אחד בעצמו הנה על איזה צד אפשר שיאמר שהכל והחלק דבר אחד כי הכל יראה מענינו שהוא זולת החלק ואם '),(2,'היו החלקים גם כן זולת הכל הנה על איזה צד יאמר בם שהם זולתו כי הכל איננו דבר זולת קבוץ החלקים וכאשר זכר זה הספק במתדבק זכר שהוא גם כן יחוייב כמו זה בכל המתמששים ואמר והחלקים גם הבלתי מתדבקים אם היה כל אחד מן הכל עד סוף פרק ירצה וחלקי הדברים המתמששים  הבלתי מתדבקים כמו היד והרגל וזולת זה מחלקי המורכבים ישיג בהם זה הספק וזה שאם היה כל אחד מן החלקים הוא הכל בעבור שהוא מן הכל ר\"ל בלתי נבדל מן הכל ולא נפרד ממנו הנה יהיו כל אחד מן החלקים דבר אחד בעצמו והוא הכל וכאשר היה זה כן חוייב שיהיו החלקים כלם דבר אחד בעצמו ויהיה הראש והצואר והיד בעצמו דבר אחד בעצמו הנה אם כן אין העצם הכל וזה אשר ביאר בו מן השקר המתחייב מהנחת הכל והחלקים דבר אחד הוא ענין מתחייב בהכרח והמאמר המקבל לזה אשר יספקו בו הקודמים לא יבארהו לפרסומות אצלםוהוא שאם היה החלק בלתי הכל והיה זה צודק על כל אחד מהחלקים הנה הוא החלקים יחד אינם הם הכל והכל אינו דבר זולתי קבוץ החלקים הנה הכל אם כן בלתי עצמו וזה המאמר הוא הטעאיי נכנס תחת המקום אשר ידומה שמה שיצדק על הדבר הנפרד יצדק עליו מורכב וזה שנה יצדק על כל אחד מן החלקים שהוא בלתי הכל ולא יצדק על כלם שהם בלתי הכל  אמר ארסטו ואם זה הכל אחד כל שהוא בלתי מתחלק הנה לא יהיה בכאן ולא כמה ולא איך ולא יהיה הנמצא גם כן אם בלתי בעל תכלית כמו שיאמר ברמנידס וזה שהבלתי מתחלק אמנם הוא התכלית לא הבעל תכלית הפירוש כאשר זכר שיחוייב להם במאמר שהוא אחד אם רצו בו הענין השני מהענינים אשר יורה עליהם שם האחד והוא הבלתי מתחלק ואמר ואם היה הכל אחד על שהוא בלתי מתחלק הנה לא יהיה לא כמה ולא איך ירצה ואם חשב חושב שהם רצו באמרם שהכל הוא אשר הוא הנמצא אחד ר\"ל הכל דבר בלתי מתחלק הנה לא יהיה בכאן כמה ולא איך ולא עצם ולא דבר משאר המאמרות לפי שאלו כלם מתחלקים אם בעצם ואם במקרה[1] מפני שקרה להם שהיו בעלי כמות וכאשר הודיע שאי אפשר לאומר בזה שיתפאר לומר שבכאן עצם או איך או כמה וזה בתכלית הבטול לקח להודיע המה שיחוייב לזה מן השקר לשני האנשים כפי הנחתם לא כפי הענין עצמו ואמר ולא היה הנמצא גם כן לא בלתי בעל תכלית כמו מה שיאמר מאלסיס ולא בעל תכלית כמו שיאמר ברמנידס וזה שהבלתי מתחלק אמנם הוא התכלית לא הבעל התכלית יצרה ויחוייב לברמנידס כפי זאת ההנחה ומאלסיס כפי מאמרם שלא יהיה המצא לא בלתי בעל תכלית כפי המ שיאמר מאלסיס ולא בכל תכלית כפי מה שיאמר ברמנידס וזה שהבלתי בעל תכלית והבעל תכלית דבר בכיתוב קטן מעל השורה עד לשוליים משמאל: \"כמו הענין באשר המאמרות כי הם אמנם ייתחלקו כמו הענין במאמר הכמה ומשל '),(3,'sit in subiecto ergo entia sunt plura. AR. Melissus vero dicit ens esse infinitum et secundum hoc ens erit aliquod quantitatem. Infinitum enim est aliquod collocatum in quanto, substantia autem infinita aut qualitas aut ubi impossibile est ut sit nisi per accidens si aliqua ex eis cum eis que sunt habuerint quantitatem. Diffinitio enim infiniti exigit quantitatem, et non substantiam neque qualitatem. Si igitur ens fuerit substantia et quantum erit duo, non unum. Et si fuerit tantum tunc ens non erit infinitum neque habebit mensusubstantiam ram omnino. Nam si habuerit mensuram erit aliquod quantum. AV. Cum declaravit quod hoc nomen ens dicitur de intentione universali et particulari scilicet individuo et quod si intenderit per illud intentionem universalem tunc non erit unum set plura. Et si intenderit intentionem particularem tunc aut erit de predicamento substantie aut de ceteris predicamentis. Et manifestum est quoniam impossibile est ut ens sit unum si intendunt aliquod individuum ceterorum predicamentorum preter substantiam aut quantum aut quale nam individua ceterorum existunt in individuis substantie et sic ens saltem erunt duo individuum accidentis et individuum substantie incepit destruere reliquum condividens et est ipsum esse individuum substantie. Et dixit Melissus vero dixit etc. id est si dixerint quod intendunt per hoc quod dicunt quod ens est unum individuum substantie tunc eorum sermo destruitur ex hoc quod ponunt quoniam alter eorum dicit ens esse infinitum scilicet Melissus alter dicit ens esse finitum scilicet Parmenides et secundum utrumque contingit si ens fuerit unum ut sit quantum tantum. Infinitam enim et finitum sunt de differentiis quantitatis. Et hoc intendebat cum infinitum dixit. Infinitum enim est collocatum in quanto. Deinde dixit substantia vero infinita etc. id est substantiam autem dici infinitam aut qualitatem aut ubi aut aliud predicamentorum impossibile est per se scilicet secundum quod est substantia aut ubi set est possibile per accidens cum fuerit potens hic est aliqua predicamentorum que cum suo esse proprio habent quantitatem ita scilicet quod quantitas acci[-] dat eis. Secundum hunc modum igitur dicitur quod substantia est infinita aut finita id est secundum quod accidit ei quod sunt quanta et similiter de aliis predicamentis. Et cum posuit quod infinitum est proprium quanti dedit rationem super hoc. Et dixit diffinitio enim infiniti etc. id est quoniam diffinitio infiniti est quantum terminatum non quantum igitur est genus infiniti quia non dicitur in diffinitione eius quod est substantia aut ubi. Et hoc quod dixit de infinito intellegendum est de finito. Deinde dixit si igitur ens etc. dicit. Et cum declaratum sit quod infinitum predicatur de quanto essentialiter et de aliis predicamentis per accidens, si intendunt cum dicunt quod ens est unum substantia et quantum substantia enim non dicitur infinita nisi secundum quod est quanta, tunc ens erit duo, non unum scilicet substantia. Et quantum secundum quod dicitur ipsa esse finita aut infinita et si intendunt substantiam tantum tunc non dicitur infinita neque habere mensuram omnino si enim haberet mensuram esset quanta. Et ista conditio est secundum sermonem non secundum rem. AR. Et etiam cum unum dicatur multipliciter sicut ens dicitur considerandum est quomodo dicunt esse unum. Dicitur enim unum aut de continuo aut de indivisibili aut de eis quorum ratio que significat quiditates est idem unum unum ut vinum et etiam numerum. AV. Cum destruxit propositionem dicentem quod ens est unum dividendo omnes intentiones de quibus dicitur ens secundum famositatem quod est subiectum propositionis incepit eam destruere dividendo intentiones de quibus dicitur unum quod est predicatum in propositione. Et dixit et etiam cum unum dicatur et cetera id est quemadmodum nobis apparuit ex divisione intentionum de quibus dicitur hoc nomen ens quod ista propositio non est vera secundum aliquam earum similiter apparebit nobis si diviserimus intentiones de quibus dicitur hoc nomen unum. Et cum dixit hoc incepit dividere secundum quot modos dicitur unum innumero. Et dicit quod dicitur tribus modis quorum unus est continuum, verbi gratia una linea et unum corpus et una superficies, secundus vero est indivisibile, verbi gratia punctus, tertius vero nomina que significant idem secundum diffinitionem, verbi gratia unum et me'),(4,'אמר אריסטוטוליס  ועוד שמאמר א׳׳א ´וג׳׳כ כיון שהאחד אמר על פנים רבים כמו שיאמר הנמצא ראוי שנעיין איך נאמר שהכל הוא אחד לפי שהאחד יאמר מה מתדבק או מה בלתי מתדבק או מאותם הדברים שהטעם אשר ירמוז עצמותם הוא אחד כמו יין וחמר. שהיה הא׳ עצמו כבר יאמר על פנים רבים כמו שיאמר הנמצא הנה כבר יחוייב שנעיין על אי זה פנים יאמרו שהכל אחד שכבר יאמר אחר אם במתדבק ואם במה שאינו מתחלק ואם בדברי׳ אשר המאמר המורה על מהותם אחד בעצמו כמו היין והחמר. אמר אריסטוטוליס´ ואם היה א׳׳א ´ ואם המתדבק יהיה הנה המתדבק אחד ורבים להיות המתדבק מתחלק לבב׳׳ת תשאר הקושיא מהחלק והכל ואף אם לא תהיה מהדרוש הזה וכן יראה היותה בעצמה והיא אם החלק והכל יהיו אחד או יותר. ועל אי זה אופן יהיו א׳ או יותר והחלקים בלתי מתדבקים אם כל אחד מהם הוא מהכל וכל אחד מהם הוא בעצמו לפי שלא יתפרד ממנו א׳׳כ צריך שישתתפו אלה עם אלה. שיובן בבעל תכלית עצמו ויעתק אליו המאמר אבל אמנם עשה המאמר בבלתי בעל תכלית לפי שהוא יותר מבואר ויותר מגונה בחקם. עוד אמר ואם היה הנמצא עצם וכמה הנה הוא שנים לא אחד ואם היה הנמצא עצם הנה אין הנמצא בלתי בעל תכלית ואין לו שעור כלל לפי שאם היה לו שעור הנה הוא כמה מה. ירצה וכאשר התבאר שהבלתי בעל תכלית ינשא על כמה בעצם ועל שאר המאמרות בדרך המקרה ר׳׳ל מדרך מה שקרה להם שיהיו בעלי חכמה ואם היה שירצו במאמרם שהנמצא הוא העצם והכמה לפי שלא יצדק על העצם שהוא בלתי בעל תכלית אלא מדרך שימצא לו הכמה הנה יהיה הנמצא לפי זה שנים לא אחד והם העצם והכמה אשר בעבורו יצדק עליו שהוא בעל תכלית ולא שיש לו שיעור כלל א לא בעל תכלית ולא בלתי בעל תכלית לפי שאם היה לו שעור היה לו כמה בהכרח וזאת הסתירה היא כפי הנחתם לא כפי הענין עצמו אמנם השתמש בה עמם אחד שהיו דבריו הנה על דרך הנצוח. הפרוש כאשר באר בטול הגזרה י׳׳ו האומרת שהנמצא אחד מפני חלוקת כל העניינים אשר יאמר עליהם שם הנמצא במפורסם והוא נושא הגזרה לקח לבטלה ג׳׳כ מצד החלק העניינים אשר יאמר עליהם שם האחד במפורסם הנה הוא נשוא הגזרה להיות הבטול נופל עליה משני צדדים מצד הנושא ומצד הנשוא ואמ׳ ועו׳ שמאחר שהאחד עצמו כבר יאמר על פנים רבים כמו שכבר יאמר הנמצא הנה כבר יחוייב שעניין על אי זה פנים יאמרו שהכל א׳ ירצה וכמו שנראה לנו מחלוקת העניינים אשר יאמר עליהם שם הנמצא שלא תצדק על אחד מהם זאת הגזרה והיא שתמצה אחר כן יחוייב שנעשה בשם האחד שהיה האחד נאמר על פנים שונים כמו שיאמר שם הנמצא ר׳׳ל שנחלקהו אל כל העניינים ונעיין באחד אחד מהם אם בצדק על הנמצא מצד מה שהוא נמצא אחד באמת אם לא. וכאשר אמרה לקח לחלק על כמה פנים יאמר האחד נמספר ואמר שהוא יאמר על שלשה עניינים אחד מהם המתדבק והוא כאמרנו קו אחד ושטח אחד וגשם אחד. והשני מה שלא יחלק כמו הנקודה. והשלישי על השמות אשר יורו על ענין אחד במהות וגדר. וירצה במאמר המורה על מהותם הגדר. הפירוש כאשר חלק העניינים י׳׳ז אשר יאמר עליהם שם האחד לקח לעיין באחד אחד אם יצדק על הנמצא מצד שהוא אחד במוחלט ר׳׳ל בלתי רבים והוא אשר סברו בו הקדמוני׳ באמרם שהנמצא אחד והתחיל בזה במתדבק כי המתדבק ממה שיאמר עליו שם האחד ואמר. ואם היה לעולם מתדבק הנה הוא א׳ והרבה וזה שהמתדבק יחלק אל מה שאין לו תכלית ירצה ואם רצו באמרם שהנמצא אחד '),(5,' הפירוש כאשר זכר מה שיחוייב י׳׳ח להם במאמר שהוא אחד אם רצו בו המתדבק מהעניינים אשר יורה עליהם שם האחד לקח להודיע מה שיחוייב להם במאמר האחד גם אם רצו בו ענין השני מכמה עניינים אשר יורה עליו שם האחד והוא הבלתי מתחלק ואמר ואם היה הכל אחד על שהוא בלתי מתחלק הנה לא יהיה לא כמה ולא איך ירצה ואם חשב חושב שאם רצו באומרם שהכל אשר הנמצא אחד ר׳׳ל הכל דבר בלתי מתחלק הנה לא יהיה בכאן כמה ולא איך ולא עצם ולא דבר משאר המאמרות לפי שאלו כלם מתחלקים אם בעצמו והוא הכמה ואם במקרה מפני שקרה להם שהיו בעלי כמות וכאשר הודיע שאי אפשר לאומר בזה שיתפאר לומר שבכאן עצם או איך או כמה וזה בתכלית הביטול לקח להודיע מה שהוא מתדבק תמיד הנה כבר יחוייב עליהם שיודו שהוא אחד מצד ורבים מצד וזה שהמתדבק כבר אפשר בו החלוק אל בלתי תכלית הנה יהיה הנמצא כפי זה אינינו אחד באמת ולא בשלוח כי הוא מצד שיחלק יהיה רבים הנה הוא אחד בפועל רבים בכח ר׳׳ל בהחלק ולמה שהיה ג׳׳כ קרה במתדבק ובכל מה שיש לו חלקים שלא יהיה הרבוי הנמצא בו מפני זולתיות החלקים קצתם לקצת אבל ג׳׳כ מפני זולתיות החלקים לכל לקח ג׳׳כ לדרוש זה הזולתיות בם ויגלגל החלקים לכל לקח בזה הספק הנופל לקדמונים בו ואמר ובכאן מקום ספק בחלק והכל וראוי שלא יהיה נכנס בזה המאמר שהוא בעצמו עומד. ירצה ובכאן מקום ספק בחלק והכל יש לו התלות בזה המאמר וראוי שלא יהיה הכנסו בזה המאמר והתלותו בו הכרחי ואם היה ספק עומד בעצמו כי הוא שיחוייב לחקור ממנו בעצמותו לא מפני התלותו בזה הדרוש וכאשר ביאר זאת הסבה המבאה לדבר בזה הספק התחיל לזכור הספק ואמר   וזהו מי יתן ואדע אם החלק והכל אחד או יותר מאחד ועל אי זה צד הם אחד ירצה וזה הספק הוא האם הכל והחלק אחד הוא דבר אחד או הם מתחלפים ואם היו אחד בעצמו הנה על אי זה צד אפשר שיאמר שהכל והחלק דבר אחד כי הכל ירצה מעניינו שהוא זולת החלק ואם היו החלקים ג׳׳כ זולת הכל הנה על איזה צד יאמר בם שהם זולתו כי הכל אינינו דבר זולת וכאשר זכר זה הספק במתדבק זכר שהוא ג׳׳כ וחוייב כמו זה בכל המשתמשים ואמר והחלקים גם הבלתי מתדבקים אם היה כל אחד מן הכל עד סוף הפרק. ירצה וחלקי הדברים המשתמשי׳ הבלתי מתדבקים כמו היד והרגל וזולת זה מחלקי המורכבים ישיג בהם זה הספק וזה שאם היה כל א׳ מן החלקים הוא הכל בעבור שהוא מן הכל ר׳׳ל בלתי נבדל מכ מן הכל ולא נפרד ממנו הנה יהיה כל א׳ מהחלקים דבר א׳ בעצמו ויהיה הראש והצאור והיד בעצמו דבר אחד בעצמו הנה ג׳׳כ אין העצם הכל וזה אשר ביאר בו מן השקר המתחייב מהנחת הכל והחלקים דבר אחד הוא ענין מתחייב בהכרח והמאמר המקבל לזה אשר יספקו בו הקודמים לא יבארהו לפרסומו אצלו והוא שאם היה החלק בלתי הכל והיה זה צורק על כל א׳ מהחלקים הנה הכל א׳׳כ בלתי עצמו וזה המאמר הוא הטעאיי נכנס תחת המקום אשר ידומה שמה שיצדק על הדבר נפרד יצדק על המורכב וזה שהנה יצדק על כל אחד מן החלקים שהוא בלתי הכל ולא יצדק על כלם שהם בלתי הכל. אמר אריסטוטוליס * וזה אם א׳׳א ואם הכל יהיה אחד באופן שיהיה בלתי מתחלק אז לא יהיה כמותיי ולא איכותיי וגם הנמצא לא יהיה בב׳׳ת כמו שאמר מיליסיו ולא בעל תכלית כמו שאמר פרמינידיס לפי שהבלתי מתחלק תכלית לא תכלה. הכל אחד על שהוא בלתי מתחלק הנה לא יהיה בכאן לא כמה ולא איך ולא יהיה הנמצא גם כן אם בלתי בעלֹ תכלית כמו שיאמר מאלסיס ולא בעל תכלית כמו שיאמר ברמינידאס וזה שהבלתי מתחלק אמנם הוא התכלית לא הבעל תכלית. '),(6,'ratio eadem et una est, que aliquid erat esse, quemadmodum vappa et vinum. Si quidem igitur continuum est quod est multa sunt. In infinitum enim continuum divisibile. Habet autem dubitationem ex parte et toto. Fortassis autem non ad rationem hanc, sed ad ipsam secundum se ipsam, utrum unum aut plura sunt partes aut totum. Et quomodo unum aut plura, si plura et non plura, quomodo plura, et etiam de partibus non continuis. Et si toti unum utrumque est sicut indivisibile, quoniam est eadem eisdem. At vero si est et sicut indivisibile est nullum erit quantum neque quale neque iam infinitum, quod est sicut Melissus dicit neque finitum, sicut Permenides terincepit dividere secundum quot modos dicitur \'unum\' in numero. Et dixit quod dicitur tribus modis, quorum unus est continuum (verbi gratia una linea et unum corpus et una superficies), secundus vero est indivisibile (verbi gratia punctus), tertius vero nomina, que significant idem secundum diffinitionem (verbi gratia unum et numerum vappa et vinum). Et intendit per rationem que significat quiditative diffinitiones. comm. 17 Cum divisit intentiones de quibus dicitur hoc nomen \'unum\', incepit considerare de unaquaque earum utrum predicetur de ente. Et dixit: Et si semper est continuum etc., idest et si intendunt per hoc quod dicunt, quod ens est unum, quod est continuum, oportet eos concedere ipsum esse unum quodammodo et plura alio modo. Continuum enim potest dividi in infinitum et sic ens non erit unum simpliciter. Est enim unum actu et plura potentia, scilicet secundum divisibilitatem, quia etiam accidit in continuo et in omni habente partes, ut multitudo eius non sit secundum diversitatem partium a se invicem, set etiam secundum diversitatem partis a toto, incepit etiam querere hanc diversitatem et inducit questionem contingentem antiquis in hoc. Et dixit: Set est questio etc., idest et est hec questio de parte et toto pendens de hoc sermone. Et visum est quod si non pendet de hoc sermone, necessario tamen est questio perscrutanda per se. Deinde induxit questionem. Et dixit: Et est utrum pars et totum etc., idest et ista questio est utrum pars et totum sint idem aut diversa, et si idem, quomodo possunt dici esse idem (totum enim videtur esse aliud a parte), et etiam si partes differunt a toto, quoniam dicuntur esse alie (totum enim nichil aliud quam congregatio partium). Et cum induxit hanc questionem in continuo, dixit: Et partes etiam non continue etc., idest et etiam in partibus rerum contiguarum et non continuarum, verbi gratia manu et pede et aliarum partium compositarum, accidit hec questio, quoniam in unaqueque partium ex toto, quia est totius, non est alia separata a toto, tunc unaqueque partium erit idem scilicet totum. Et sic omnes partes erunt eedem, ergo et caput et manus et collum erunt idem, ergo pars non est totum. Et illud impossibile quod sequitur si totum et pars fuerint idem, sequitur negatio necessario. Et sermo oppositus isti non exprimitur propter suam famositatem, et est quod si omnis pars est alia a toto, tunc omnes partes erunt aliud a toto et totum nichil aliud est quam congregatio partium, ergo totum est aliud a se. Et illud sophisma est compositionis et divisionis, quoniam unaqueque partium dicitur esse aliud a toto, set omnes insimul non possunt dici esse aliud a toto. comm. 18 Cum induxit illud quod contingit eis, si intenderunt per unum continuum, induxit etiam impossibile contingens eis, si intenderint per hoc \'unum\' indivisibile. Et dixit: Et si totum fuerit unum etc., idest et si aliquis dixerit quod, cum dixerunt totum ens esse unum, intendebant esse indivisibile, tunc non erit quantum neque quale neque substantia neque aliquod aliud predicamentorum, quoniam omnia ista sunt divisibilia que significat qui dicatur est idem, ut unum et numerum. Et si semper est continuum, est unum et multum. Continuum enim dividitur in infinitum. Set est hic questio de parte et toto; si non est huius sermonis, videtur existere per se, et est utrum pars et totum sint unum aut plura uno, et secundum quemadmodum sunt unum aut plura uno; et partes non continue, si quelibet est totius et unaqueque est idem, quia non separatur ab eo, ergo necesse est ut quedam conveniant cum quibusdam Et si totum fuerit unum ita quod indivisibile sit, tunc non erit quantum aut quale. Et etiam ens non erit infinitum, ut dicit Melissus, neque finitum'),(7,'unum dividendo omnes intentiones de quibus dicitur ens secundum famositatem quod est subiectum propositoinis incepit destruere eam dividendo intentiones de quibus dicitur unum quod est predicamentum in propositione et dixit et etiam cum unum dicatur etc. idest et quemadmodum nobis aparuit ex divisione intentionum de quibus dicitur hoc nomen ens quod ista propositio non est vera secundum aliqua earum similiter aparebit nobis si diviserimus intentiones de quibus dicitur hoc nomen unum, et cum dixit hoc incipere dividere secundum quos modos dicitur unum in numero et dixit quod tribus modis dicitur quorum unum est continuum Verbi gratia una linea et unum corpus et una superficies sensus vero indivisibile, verbi gratia punctus tertius vero nomina que significant idem secundum diffinitionem verbi gratia unum et et intendit rationem que significat quiditatem diffinitiones. AR Et si semper est etc. AV Cum divisit intentiones de quibus dicitur hoc nomen unum incepit declarare et considerare de unaquaque earum utrum predicetur de ente et dixit et si semper est continuum etc. idest et si intendunt per hoc quod dicunt quod est ens unum quod est continuum oportet eos concedere ipsum esse unum quodammodo et plura alio modo continuum potest dividi in infinitum et sic ens non erit simpliciter, est enim unum actu et plura potentia secundum divisibilitatem et quia etiam accidit in con et omni habenti partes ut multitudo eius non sit secundum diversitatem partium invicem, sed et etiam secundum diversitatem partis a toto. Incepit etiam querere hanc diversitatem et induxit questionem contingentem antiquis in hoc et dixit sed et est questio etc. idest et hoc questio est de parte et toto pendens de hoc sermone et visum est quod si non pen det de hoc sermone neccessario tamen est questio per se scrutanda. deinde induxit questionem etc. et dixit et est utrum pars et totum etc. idest et ista questio est utrum pars et totum sint idem aut diversa et si idem quomodo possunt dici idem, totum enim videtur aliud esse a parte et si etiam partes differunt a toto, quomodo dicuntur esse alie, totum enim nihil aliud est quam congregatio partium, et cum induxit hanc questionem in continuo dixit, et partes etiam non continee etc. idest et in partibus rerum contiguarum non continuarum verbi gratia manu et pede et aliarum compositarum partium accidit hoc quod quoniam si unaqueque partium ex toto quia est totius idest non separata a toto, tunc unaqueque partium erit idem scilicet totum, et sic omnes partes erunt inter se eedem, ergo et caput et manus et collum erunt idem, ergo pars non est totum, et istud impossibile quod sequitur, si totum et pars sunt idem, sequitur neccessario et sermo oppositus isti non exprimitur propter suam et est si omnis pars est alia a toto tunc omnes partes erunt aliud a toto et totum nihil aliud est quam congregatio partium, ergo totum est aliud a se, et istud sophisma est compositionis et divisionis, quoniam unaqueque partium dicitur esse aliud a toto, sed omnes in simul non possunt aliud dici a toto. AR Et si totum fuerit unum etc. AV Cum induxit illud quod contingit eis si intenderint per unum continuum Induxit etiam impossibile contingens eis si intenderint per hoc nomen unum indivisibile et dixit et si totum fuerit unum etc. idest si aliquis dixerit quod cum dixerit totum ens esse unum intendebat esse indivisibile, tunc non erit hoc quantum neque quale neque substantia neque aliud aliquod predicamentorum, quoniam omnia ista sunt divisibilia, aut per se et est quantum aut per accidens et cum declaravit quod dicens hoc non potest concedere hoc esse substantiam aut quale aut quantum quod est valde improbabile incepit declarare Impossibile quod continget hiis duobus viris secundum hoc quod ponunt non secundum rem in se et dixit et ens etiam non erit infinitum ut melisus dicit neque finitum ut parmenides, nam finitum et infinitum non dicuntur nisi de quanto, non de fine quanti. AR Et si entia omnia fuerint unum etc. AV Cum destruxit duos modos secundum quos dicitur hoc nomen unum, incepit destruere tertium, et dixit et si entia etc. idest et si intenderint per hoc quod dicunt quod entia diversorum nominum omnia sunt idem secundum diffinitionem adeo quod significatio horum nominum homo equus asinus si sicut significatio horum vestis et tunica nominum continget eis dicere quod dixit eraclitus sophista s'),(8,'erit de predicamento substantie aut de ceteris predicamentis, et est manifestum quod impossibile est ut ens sit unum, si enim intenderint aliquod individuum ce[-] terorum predicamentorum preter substantiam aut quantum aut quale (nam individua ceterorum existunt in individuis substantie et sic ens saltem erit duo, individuum accidentis et individuum substantie), incepit destruere reliquum condividens, et est ipsum esse individuum substantie. Et dixit: [¶]Me[-] lissus vero dicit etc., idest et si dixerint quod intendunt per hoc quod dicunt, quod ens est unum individuum substantie, tunc sermo eorum destruitur ex hoc quod po[-] nunt, [¶]quoniam alter eorum dicit ens esse infinitum, scilicet Mellissus, et alter dicit finitum, scilicet Parmenides. Et secundum utrumque contingit, si ens fuerit unum, ut sit quantum tantum; infinitum enim et fini[-] tum sunt de differentiis quantitatis. Et hoc intendit[note] cum dixit: [¶]Infinitum enim est collocatum in quanto. [¶]Deinde dixit: Substantia vero infinita etc., idest substantiam autem dici infinitam aut qualitatem aut ubi aut aliud predicamentum impossibile est per se, scilicet secundum quod est substantia aut ubi, sed est[note] possibile per accidens cum fuerit positum hic esse aliquod predicamentorum, que cum suo esse proprio habent quan[-] titatem, ita scilicet quod quantitas accidat eis. Secundum igitur hunc modum dicitur quod substantia aut[note] est finita aut infinita, idest secundum quod accidit ei quod fuerit quanta, et similiter de aliis predicamentis. Et cum posuit quod infinitum est proprium quanti, dedit rationem super hoc. Et dixit: [¶]Diffinitio enim infiniti etc., idest quantum diffinitio infiniti est, quantum non terminatum. ecce quod quantum est genus finiti et infiniti. vult etiam quod diffinitio infiniti est quantum non terminatum Quantum igitur est genus infiniti, quia non dicitur in dif[-] finitione eius quod est substantia aut ubi. Et hoc quod dicit de in[-] finito intellegendum est de finito. [¶]Deinde dixit: Sed igitur ens etc., dicit: Et cum declaratum sit quod infinitum predicatur de quanto essentialiter et de aliis predicamentis sed per accidens, si intendunt, cum dicunt ens est unum, substantiam et quantum (substantia enim non dicitur infinita nisi secundum quod est quanta), tunc ens erit duo, non unum, scilicet substantia et quantum, secundum quod dicitur ipsa esse finita aut infinita; et si intendunt substantiam tantum, tunc non dicitur infinita neque habere mensuram omnino; si enim haberet mensuram, esset quanta necessario. Et ista contradictio est secundum sermonem, non secundum rem. Amplius quoniam et ipsum unum Et etiam cum unum dicatur multipliciter, sicut ens dicitur, considerandum est quomodo dicunt esse unum. Dicitur enim unum aut de continuo aut de indivisibili aut de eis quorum ratio que significat quiditates est idem, ut vinum et merum. 16 Cum destruxit propositionem dicentem, quod ens est unum, dividendo omnes intentiones de quibus dicitur ens secundum famositatem quod est subiectum propositionis, incepit eam destruere dividendo intentiones de quibus dicitur unum quod est predicatum in propositione. Et dixit: Et etiam cum unum dicatur etc., idest quemadmodum apparuit nobis ex divisione intentionum de quibus dicitur hoc nomen \'ens\' quod ista propositio non est vera secundum aliquam earum, similiter apparebit nobis si divisimus intentiones de quibus dicitur hoc nomen \'unum\'. Et cum dixit hoc, incepit dividere secundum quot modos dicitur \'unum\' numero. Et dixit quod dicitur tribus modis, quorum unum est continuum (verbi gratia una linea et unum corpus et una superficies), secundus vero in indivisibile (verbi gratia punctus), tertius vero nomina que significant idem secundum diffinitionem (verbi gratia unum et numerum). Et intendit per rationem que significat quiditatem, diffinitioneis. Si quidem ergo continuum sit Et si semper est continuum est unum et multum. Continuum enim dividitur in infinitum. Sed est hic questio de parte et toto; et si non est huius sermonis, videtur existere per se, et utrum pars et totum sint unum aut plura uno, et secundum quem modum sint unum aut plura uno; et partes etiam non continue, si quelibet est totius et unaqueque est idem, quia non separatur ab eo, ergo necesse est ut quedam conveniunt cum quibusdam. 17 Cum divisit intentiones de quibus dicitur hoc nomen \'unum\', incepit cons'),(9,'etc., et si intendunt per hoc quod dicunt quod ens est unum, quod est continuum, oportet eos concedere ipsum esse unum quodammodo et plura alio modo. Continuum enim potest dividi in infinitum et sic ens non erit unum simpliciter. Est enim unum actu et plura potentia, scilicet secundum divisibilitatem. Et quia etiam accidit in continuo et in omni habenti partes, ut ut multitudo eius non sit secundum diversitatem partium a se invicem, sed etiam secundum diversitatem partis a toto, incepit etiam querere hanc diversitatem et inducit questionem contingentem antiquis in hoc. Et dixit: Sed est questio etc., idest et est hic questio de parte et toto pendens de hoc sermone. Et unum est si non pendet de hoc sermone, necessario tamen est questio perscrutanda per se. Deinde induxit questionem. Et dixit: Et est utrum pars et totum etc., et ista questio est utrum pars et totum sint idem aut diversa, et si idem, quomodo possunt dici idem dici esse (totum enim videtur aliud esse a parte), et etiam si partes differunt a toto, quomodo dicuntur esse alie (totum enim nichil aliud est quam congregatio partium). Et cum induxit hanc questionem in continuo, dixit: Et partes etiam non continue etc., idest et etiam in partibus rerum contiguarum et non continuarum, verbi gratia manu et pede et aliarum partium compositarum, accidit hec questio, quoniam si munaquaque partium ex toto est idem toto, quia est totius, idest non separata a toto, tunc unaqueque partium erit idem scilicet totum. Et sic omnes partes erunt eedem, ergo et caput et manus et collum erunt idem, ergo pars non est totum. Et istud impossibile, quod sequitur si totum et pars sint idem, sequitur necessario. Et sermo oppositus isti non exprimitur propter famositatem suam, et est quod si omnis pars est alia a toto, tunc omnes partes erunt aliud a toto et totum nichil aliud est quam congregatio partium, ergo totum aliud est a se. Et istud sophisma est compositionis et divisionis, quoniam unaqueque partium dicitur esse aliud a toto, sed omnes insimul non possunt dici aliud a toto. At vero si est sicut indivisibile Et si totum fuerit unum ita quod sit indivisibile, tunc non erit quantum aut quale. Et etiam ens non erit infinitum, ut dicit Melissus, neque finitum, ut dicit Parmenides; indivisibile enim est finis, non finitum. 18 Cum induxit illud quod contingit eis, si intenderunt per unum continuum, inducit etiam impossibile contingens eis, si intenderunt per hoc nomen \'unum\' indivisibile. Et dixit: Et si totum fuerit unum etc., idest et si aliquis dixerit quod, cum dixerunt totum ens esse unum, intendebant esse indivisibile, tunc non erit hic quantum neque quale neque substantia neque aliud aliquod predicamentorum, quoniam omnia ista sunt divisibilia aut per se, et est quantum, aut per accidens. Et cum declaravit quod dicens hoc non potest concedere hic substantiam aut quale aut quantum, quod est valde improbabile, incepit declarare impossibile, quod contingit hiis duobus viris secundum hoc quod ponuntur, non secundum rem in se. Et dixit: Et ens etiam non erit infinitum etc., idest et contingit Parmenidei et Melisso secundum hoc quod dicunt, ut ens non sit infinitum, ut Melissus dicit, neque infinitum, ut Parmenides. Nam finitum et infinitum non dicuntur nisi de quanto, non de fine quanti. At vero si ratione unum sunt que sunt Et si omnia entia fiunt unum secundum sermonem, ut vestis et tunica, continget eis dicere quod Eraclitus dicit; esse enim erit boni et mali, unum et boni et non boni; ex quo sequitur ut bonum et non bonum erunt idem et homo et equus. Et tunc sermo eorum non erit in hoc quod entia sunt unum, sed in hoc, quod nullum eorum est. Et erit etiam intentio quiditatis talis dispositionis, idest qualitatis, et intentio eius talis mensure, idest quantitatis, eadem intentio. 19 Cum destruxit duos modos illorum trium secundum quos dicitur hoc nomen \'unum\', incepit destruere tertium. Et dixit: Et si entia etc., idest et si intenderunt per hoc quod dicunt quod entia diversorum nominum omnia sunt idem secundum diffinitionem adeo quod significatio horum nominum \'homo\', \'equus\', \'asinus\' sit, sicut significatio horum nominum '),(10,'Loki ist ein toller Hund!'),(11,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam elit arcu, tempus eu condimentum ut, gravida a dolor. Nullam eget aliquet ex. Suspendisse pellentesque non augue et vestibulum. Aliquam varius rhoncus convallis. Morbi tortor nulla, egestas a auctor eget, fermentum a lorem. Nulla nec luctus neque. Integer quis porta nunc. Donec sed malesuada turpis. In hac habitasse platea dictumst. Nam ac gravida dolor, sed ultricies ligula. Cras non pellentesque libero, et tempus nisi.\n\nNunc sed porta ex, vitae dapibus libero. Praesent convallis eget risus non consectetur. In semper enim eu magna dictum porttitor. In porta mattis massa, sit amet venenatis ante blandit et. Ut id ornare orci. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed gravida sapien a leo dapibus, et consectetur erat blandit. Praesent fringilla ligula est, ut mollis risus aliquet a. Fusce vulputate elementum odio at porttitor. Aliquam dignissim pretium cursus. Donec eu purus id lorem tincidunt faucibus. Morbi vehicula nibh quis felis bibendum, quis porttitor dui dignissim. Duis pretium maximus augue non dictum. Suspendisse nec lobortis eros. Ut molestie eget dolor vitae pulvinar.\n\nDonec tellus enim, elementum ac viverra vitae, vulputate non arcu. Donec consequat in magna quis mollis. Interdum et malesuada fames ac ante ipsum.'),(12,'Si igitur quod vere est nulli accidit,\nsed illi aliquid magis quod vere est\nsignificat quod est si enim erit quod vere\nest idem et album, album autem non est quod\nvere est, neque accidere ipsi possibile est quid\nest, neque enim quod est, est quod non vere est\nnon ergo quid est, est quod album est, non\nsic autem sicut qum aliquod non sit, sed\nomnino non sit, quod vere itaque est non\nest verum enim dicere est, quoniam album \nest, hoc autem non quod est significat,\nquare si album significat quod est, mul[-]\nta ergo significat quod est. Et si illud quod est ens non accidit ali[-]\ncui omnino, sed ei dignius accidit illud \nquod accidit ergo ens significat illud quod  \nest ens, aut significat non ens. Quoniam si\nillud quod est ens sit album, quia intencio\nintencio albi non est illud quod est ens\n\nalbi non est illud quod est ens. Nam im[-]\npossibile est ut ens accidat ei, et quia non \nest ens nisi illud quod est ens, ergo album \nnon est ens, non ita quod sit illud quod est \nens, sed ita quod est non ens omnino, ergo \nnecesse est ut illud quod est ens sit non ens, \ndicere enim ipsum esse album est verum, \nsed dicere hoc significabat non ens ergo \nnecesse est ex hoc ut album etiam signi[-]\nficet ens, ergo ens significat plures inten[-]\nciones. \n[¶] Qum redarguit Parmenidem in hoc quod \nposuit quod ens significat unum quod est acci[-]\ndens, incepit etiam redarguere ipsum si po[-]\nsuerit ipsum ens significare unum quod est \nredarguit Parmenidem si posuerit ipsum ens significare unum quod est substancia\n\nsubstancia, et dixit, et si illud quod est ens etc. \nidest si intendit qum dixit quod ens est unum\nquod est illud cui accidit omnino, sed omnia \nque accidunt equid ei accidunt, tunc ens apud ip[-]\nsum significat illud quod est ens in rei veri[-]\ntate, et ens significat non ens. Deinde ince[-]\npit declarare quomodo sequitur hoc et dix[-]\nit, quoniam si illud quod est ens etc. idest quo[-]\nniam illud quod est ens dicitur esse album\nintencio albi est alia ab intencione entis\n\nquia intencio albi est alia ab intencione \nentis, nam impossibile est ut ens accidat \nsibi, et in alia translacione, nam impossi[-]\nbile est ut accidat ei ut sit ens, idest quoni[-]\nam dicere aliquid esse non est predicacio per \naccidens, sicut predicacio albedinis. Dein[-]\nde dixit, et quia non est ens etc. idest quia\npositum est quod non est ens nisi subiectum '),(13,'Igitur quod vere est nulli accidit.\nEt si illud quod est ens nulli accidit\nalicui sed ei dignius accidit illud quod accidit\nergo ens significat illud quod est ens aut significat\nnon ens, quoniam si illud quod est ens sit album,\nquia intencio intencio albi non est illud quod est ens\nalbum non est ens, non ita quod sit illud quod est\nens, sed ita quod est non ens omnino, ergo necesse est ut il[-]\nlud quod est ens sit non ens, dicere, enim, album\nest unum, sed dicere hoc significabat non ens,\nergo necesse est ex hoc non album etiam significet\nens et plures intentiones. \nCum redarguit Parmenidem in hoc quod posuit quod ens significat unum quod\nest accidens, incepit etiam redarguere ipsum si posuit ipsum ens significare\nunum quod est substancia et dixit et si illud quod est ens etc. idest et si intendit \ncum dixit quod ens est unum quod est illud cui non accidit omnino sed omnia que acci[-]\ndunt, ei accidunt, tunc ens apud ipsum significat illud quod est ens in rei veritate\net ens significat non ens. Deinde incepit declarare quomodo hoc sequitur hoc et dixit quoniam illud\nquod est ens etc. idest quoniam non est illud quod est ens dicitur esse album quoniam intencio albi\nest alia ab intencione entis, nam impossibile est ut ens accidat sibi, et in alia trans[-]\nlacione, nam impossibile est ut accidat ei ut sit ens, idest quoniam di[-]\ncere aliquid esse non est predicacio per accidens sicut predicacio albedinis. Deinde dixit, et quia non ens\netc. idest quia iam positum est quod non est ens nisi subiectum albi, igitur album\nnon est ens, non ita quod sit non est ens quod ponit Parmenides esse ens, et est\naliquod ens, sed ita quod sit non ens omnino. Deinde dixit igitur necesse esset ut illud\nquod est ens sit non ens, idest contingit igitur ut sit ens illud quod non est ens, deinde \ndeclaravit hanc consecucionem, et dixit dicere enim ipsum esse album etc. idest dicere enim\nquod ens est album est ponere album esse ens, quia ista proposicio est vera, et iam declaratum\nest quod hoc nomen album significat non ens secundum posicionem adversarii, ex quo sequitur\nut ens significet illud quod ipse posuit non ens. Deinde dixit, igitur ens etc. idest\nigitur ens significat illud quod ipse posuit et est illud quod recipit albedinem\net illud quod posuit non ens sed albedinem, igitur ens significat plura.\n Neque igitur magnitudo erit, quod est. \n Et etiam ens non est magnitu[-]\ndo si ens est illud quod est ens. Intentio\nenim utriusque partis alia est ab altera, \net manifestum est quod illud quod est ens de\nratione etiam in aliquas partes que sunt\netiam illud quod est ens, verbi gratia, quoniam homo si\nsit illud quod est ens, necesse est ut animal etiam sit\nillud quod est ens, et bipes. nam si non\nsint illud quod est ens, ergo erunt accidentia,\naut ergo homini accidunt aut alteri subiecto, ac[-]\ncidens enim dicitur aut de illo quod potest esse alicu\nius aut non esse, aut de illo in cuius ratione\naccipitur illud autem accidit; verbi gratia sessio\naut quasi separatum, simitas vero ratio nasi accipitur in \neodem quo dicimus quod simitas accidit ei.\nCum redarguit Parmenidem proprie, intendit redarguere sive\ncontradicere eis ambobus communiter et dixit et etiam ens non est\nmagnitudo etc, id est et etiam ens secundum hanc opinionem impossibile ut dicatur\nesse corpus, cum ens apud eos sit ens principaliter et corpus dicitur de\nquantitate et substantia, erit igitur esse substantie aliud ab esse quantitatis, et forte intendit quod\nsi ens fuerit unum impossibile est ut sit corpus nam corpus est divisibile, et hoc\nmanifestius est ut mihi videtur. Deinde incepit contradicere eis aliquo modo\net dixit et manifestum est etc, id est et universaliter si non crediderint ipsum esse corpus necesse\nest ut habeat diffinitionem ex qua intellegatur eius substantia, scilicet ut habeat aliquid ut \ngenus, et aliquid ut differentiam. Deinde induxit exemplum et dixi, verbi gratia homo etc, id est\nverbi gratia quoniam si posuerimus quod ens est unum apud eos sicut homo necesse\nest ut sit animal quod est genus hominis, et bipes quod est eius differentia, sint entia\nin rei veritate nam partes rei que sunt secundum diffinitionem, praecedunt rem in esse,'),(14,'Si igitur quod vere est nul[-]\nli accidit, sed illi accidit aliquid\nvere est magis significat quod\nest que quod non est vere, si\nenim erit quod vere est idem\net album, albo autem esse non\nest quid vere est, non enim\nneque ipsi accidere possibile\nest quid est, neque enim quid est\nest quod non vere est, non ergo\nquid est, est quod album est, non sic\nautem sicut aliquod non sit\nalbum, sed omnino non sit quod vere est,\nitaque non est, verum est enim dicere quo[-]\nniam album est, hoc autem non quod est\nsignificat quare et si album significat\nquod neque est, multa ergo signi[-]\nficat quod vere est.\nEt si illud quod est\nalicui non\nomnino ens accidit, sed\nei dignius accidit\nillud quod accidit er[-]\ngo ens significat illud\nquod est ens, aut signifi[-]\ncat non ens quoniam\nsi illud quod est ens\nnam impossibi[-]\nle est ut ens ac[-]\ncidat ei et quia non\nest ens nisi illud\nquod est ens ergo al[-]\nbum non est ens\nnon ita quod sit illud\nquod est ens, sed ita\nquod est non ens omni[-]\nno ergo necesse est\nut illud quod est ens\nsit non ens, dicere\nenim ipsum esse album\nest verum sed dicere hoc\nsignificabat non ens\nergo necesse est ex hoc\nut album etiam signi[-]\nficet ens ergo ens\nsignificat plures in[-]\ntentiones. \nCum redargu[-]\nit Parmenidem\nproprie in hoc quod posuit\nquod ens significat unum quod est\naccidens, incepit etiam redarguere ipsum si posuerint ipsum ens significare unum\nquod est, substancia, et dixit et si illud quod est ens etc, idest et si intendit cum dicit quod ens est\nunum quod est illud cui non accidit omnino, sed omnia que accidunt ei accidunt tunc ens apud ipsum\nsignificant illud quod est ens in rei veritate, et ens significat non ens. Deinde incepit\ndeclarare quo modo sequitur hoc et dixit, quoniam si illud quod est ens dicitur esse al[-]\nbum quia intentio albi est alia ab intencione entis, nam impossibile est ut acci[-]\ndat ens sibi, et in alia translacione, nam impossibile est ut accidat ei quod sit ens, idest quoniam dicere aliquid esse non est predicacio per accidens sicut\npredicacio albedinis, deinde dixit et quia non est ens etc. idest quia causa iam positum\nest quod non est ens nisi subiectum albedinem ergo album non est non ens, non ita quod\nsit non ens quod ponit Parmenides esse ens et est ens aliquod sed ita quod sit non ens omni[-]\nno. Deinde dixit, ergo necesse esset ut illud quod est ens sit non ens idest contingit\nigitur ut sit ens illud quod non est ens. Deinde declaravit hanc consecu[-]\ntionem et dixit. Dicere enim ipsum esse album est verum etc. idest dicere enim quod ens est \nalbum est ponere album esse ens, quia ista proposicio est vera et iam declaratum est, quod hoc \nnomen album significat non ens secundum posicionem adversarii ex quo sequitur ut ens\nsignificet illud quod ipse posuit non ens. Deinde dixit ergo ens etc. idest ergo\nens etc, significat illud quod posuit ens, et est illud quod recipit albedinem et illud\nquod posuit non ens scilicet albedinem ergo ens significat plura.[Chunk]\n[Chunk] Et etiam ens non est\nmagnitudo\nsi ens est illud, quod est\nens. Intentio enim \nentis utriusque partis\nest alia ab altera. Et \nmanifestum est quod illud quod\nest ens dividitur\nratione etiam in alias par[-]\ntes que sunt etiam illud\nquod est ens, verbi gratia, quoniam homo \nsi sit illud quod est ens ne[-]\ncesse est ut animal\netiam sit illud quod est ens et bi[-]\npes, nam si non fu[-]\nerint illud quod est ens,\nergo sunt accidentia \naut ergo homini\naccidunt aut alteri \nsubiecto, accidens enim dicitur\naut de illo in cuius \nratione accipitur illud\ncui accidit, verbi gratia sessi[-]\no autem quasi separatum \nsimitas vero ratio si\naccipitur in ea de\nquo dicimus quod si[-]\nmitas accidit ei.\nCum redarguit\nParmenidem proprie\nincepit contradicere\neis ambobus communiter\net dixit et etiam ens non est\nmagnitudo etc, id est et etiam\nens secundum hanc opinio[-]\nnem impossibile est ut di[-]\ncatur esse corpus cum\nens apud eos sit ens\nprincipaliter, et corpus dicitur de substantia et quantitate erit igitur\nesse substantie aliud ab esse quantitatis, et forte intendit quod si ens\nfuerit unum impossibile est ut sit corpus, nam corpus est divisibile et hoc est mani[-]\nfestius ut mihi videtur. Deinde incepit contradicere eis alio modo et\ndixit, et manifestum est etc, id est et universaliter, si non crediderint ipsum esse corpus necesse est\nut hanc diffinitionem ex qua intellegatur eius substantia, scilicet ut habeant aliquid\nquasi genus et aliquid quasi differentiam. Deinde induxit exemplum et dixit, verbi gratia \nhomo etc, id est verbi gratia quoniam si posuerint quod ens quod est unum apud eos sit homo necesse est\nut animal quod est genus hominis, et bipes quod est eius differentia sint entia in\nrei veritate nam partes rei que sunt secundum diffinitionem praecedunt rem in esse \nNeque igitur magni[-]\ntudo erit quod est si quidem\nest quod vere est, utique nam\nalterum est esse partium. Quod autem\ndividitur quod vere est et\nratione manifestum est ut\nsi homo quod vere est aliquid necesse est et\nanimal, quod vere, sed est aliquid\nnesse est, et animal quod vere est,\naliquid esse et bipedem, si\nnon quod vere est, sunt acci[-]\ndentia erunt, aut igitur\nhomini aut alicui alii subiecto,\nsed hoc impossibile est accidens enim dicitur aut\nhoc quod contingit esse et non esse\naut cuius est esse in ratione, hoc cui\naccidit ut federe quidem sicut separ[-]\nabilem, in simo autem est na[-]\nris ratio cui accidere dicimus si[-]\nmum esse.\n');
/*!40000 ALTER TABLE `plaintexts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `standoff_properties`
--

DROP TABLE IF EXISTS `standoff_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `standoff_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_name` varchar(255) DEFAULT NULL,
  `property_value` varchar(255) DEFAULT NULL,
  `type` enum('text','faksimile') NOT NULL,
  `transc_page_id` int(11) DEFAULT NULL,
  `fak_page_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `standoff_properties`
--

LOCK TABLES `standoff_properties` WRITE;
/*!40000 ALTER TABLE `standoff_properties` DISABLE KEYS */;
INSERT INTO `standoff_properties` (`id`, `property_name`, `property_value`, `type`, `transc_page_id`, `fak_page_id`) VALUES (1,'chunk','1','text',3,NULL),(2,'italics',NULL,'text',3,NULL),(5,'chunk','1','faksimile',NULL,1),(7,'chunk','1','faksimile',NULL,2),(17,'italics',NULL,'text',3,NULL),(20,'italics',NULL,'text',5,NULL),(21,'italics',NULL,'text',3,NULL),(22,'italics',NULL,'text',3,NULL),(23,'bold',NULL,'text',3,NULL),(28,'underline',NULL,'text',3,NULL),(45,'bold',NULL,'text',3,NULL),(48,'bold',NULL,'text',3,NULL),(52,'chunk','1','text',3,NULL),(63,'italics',NULL,'text',10,NULL),(64,'underline',NULL,'text',10,NULL),(66,'bold',NULL,'text',3,NULL),(67,'underline',NULL,'text',3,NULL),(68,'chunk','1','text',11,NULL),(71,'chunk','1','text',4,NULL),(72,'chunk','1','text',5,NULL),(78,'bold',NULL,'text',11,NULL),(79,'italics',NULL,'text',11,NULL),(80,'bold',NULL,'text',11,NULL),(81,'italics',NULL,'text',11,NULL),(82,'underline',NULL,'text',11,NULL),(83,'bold',NULL,'text',11,NULL),(84,'italics',NULL,'text',11,NULL),(85,'bold',NULL,'text',11,NULL),(86,'italics',NULL,'text',2,NULL),(87,'underline',NULL,'text',2,NULL),(88,'chunk','3','text',12,NULL),(89,'chunk','3','faksimile',NULL,3),(90,'chunk','3','text',13,NULL),(91,'chunk','3','faksimile',NULL,4),(92,'chunk','4','text',13,NULL),(93,'chunk','4','faksimile',NULL,4),(95,'chunk','3','text',14,NULL),(96,'chunk','4','text',14,NULL),(97,'chunk','3','faksimile',NULL,5),(98,'bold',NULL,'text',14,NULL),(99,'bold',NULL,'text',14,NULL),(100,'bold',NULL,'text',14,NULL),(101,'underline',NULL,'text',14,NULL),(102,'bold',NULL,'text',13,NULL),(103,'italics',NULL,'text',13,NULL);
/*!40000 ALTER TABLE `standoff_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `standoff_properties_faksimile`
--

DROP TABLE IF EXISTS `standoff_properties_faksimile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `standoff_properties_faksimile` (
  `id` int(11) NOT NULL,
  `x1` int(11) DEFAULT NULL,
  `y1` int(11) DEFAULT NULL,
  `x2` int(11) DEFAULT NULL,
  `y2` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `standoff_properties_faksimile_standoff_properties_id_fk` FOREIGN KEY (`id`) REFERENCES `standoff_properties` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `standoff_properties_faksimile`
--

LOCK TABLES `standoff_properties_faksimile` WRITE;
/*!40000 ALTER TABLE `standoff_properties_faksimile` DISABLE KEYS */;
INSERT INTO `standoff_properties_faksimile` (`id`, `x1`, `y1`, `x2`, `y2`) VALUES (5,20,20,70,70),(7,10,10,30,30),(89,95,7,63,50),(91,18,39,45,41),(93,18,41,45,80),(97,55,27,72,67);
/*!40000 ALTER TABLE `standoff_properties_faksimile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `standoff_properties_text`
--

DROP TABLE IF EXISTS `standoff_properties_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `standoff_properties_text` (
  `id` int(11) NOT NULL,
  `index` int(11) DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `standoff_properties_text`
--

LOCK TABLES `standoff_properties_text` WRITE;
/*!40000 ALTER TABLE `standoff_properties_text` DISABLE KEYS */;
INSERT INTO `standoff_properties_text` (`id`, `index`, `length`) VALUES (1,50,50),(2,40,8),(17,9,3),(20,1,6),(21,447,8),(22,655,2),(23,935,11),(28,93,21),(45,7,8),(48,931,2),(52,1279,457),(63,13,6),(64,0,25),(66,1288,8),(67,1308,4),(68,0,579),(71,0,292),(72,105,392),(78,233,7),(79,228,8),(80,0,5),(81,264,4),(82,257,9),(83,265,15),(84,29,11),(85,980,9),(86,48,4),(87,139,4),(88,0,502),(90,0,34),(92,36,2285),(95,0,600),(96,600,4153),(98,0,1),(99,600,1),(100,1215,1),(101,1244,8),(102,0,6),(103,784,4);
/*!40000 ALTER TABLE `standoff_properties_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transcription_pages`
--

DROP TABLE IF EXISTS `transcription_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transcription_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plaintext_id` int(11) DEFAULT NULL,
  `transcription_id` int(11) DEFAULT NULL,
  `transcriber` varchar(255) DEFAULT NULL,
  `page_number` int(11) DEFAULT NULL,
  `page_folio` varchar(255) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transcription_pages_transcriptions_id_fk` (`transcription_id`),
  CONSTRAINT `transcription_pages_transcriptions_id_fk` FOREIGN KEY (`transcription_id`) REFERENCES `transcriptions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transcription_pages`
--

LOCK TABLES `transcription_pages` WRITE;
/*!40000 ALTER TABLE `transcription_pages` DISABLE KEYS */;
INSERT INTO `transcription_pages` (`id`, `plaintext_id`, `transcription_id`, `transcriber`, `page_number`, `page_folio`, `language`) VALUES (1,1,1,NULL,27,'11v','heb'),(2,2,1,NULL,28,'12r','heb'),(3,3,2,NULL,20,'9r','lat'),(4,4,3,NULL,32,'15v','heb'),(5,5,3,NULL,33,'16r','heb'),(6,6,4,NULL,24,'','lat'),(7,7,5,NULL,11,NULL,'lat'),(8,8,6,NULL,16,NULL,'lat'),(9,9,6,NULL,17,NULL,'lat'),(11,11,2,NULL,21,'9v','lat'),(12,12,7,NULL,29,NULL,'lat'),(13,13,8,NULL,15,'6r','lat'),(14,14,9,NULL,27,'11v','lat');
/*!40000 ALTER TABLE `transcription_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transcriptions`
--

DROP TABLE IF EXISTS `transcriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transcriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transcriptions`
--

LOCK TABLES `transcriptions` WRITE;
/*!40000 ALTER TABLE `transcriptions` DISABLE KEYS */;
INSERT INTO `transcriptions` (`id`, `identifier`) VALUES (1,'M-FR-PAR-BNF-heb.884'),(2,'M-FR-PAR-BNF-lat.15453'),(3,'M-GB-OXF-BOD-Bodl.Or.155'),(4,'M-IT-FLR-BML-Leop.Med.Fesul.162'),(5,'M-US-NYC-MOR-M.858'),(6,'M-VA-VAT-BAV-Vat.lat.2076'),(7,'M-ES-SVQ-BU-A.330.154'),(8,'M-FR-PAR-BNF-lat.16150'),(9,'M-FR-PAR-BNF-lat.17155');
/*!40000 ALTER TABLE `transcriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `works`
--

DROP TABLE IF EXISTS `works`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `works` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works`
--

LOCK TABLES `works` WRITE;
/*!40000 ALTER TABLE `works` DISABLE KEYS */;
INSERT INTO `works` (`id`, `name`, `author`) VALUES (1,'Long Commentary on the Physics','Averroes'),(2,'Physics','Aristotle');
/*!40000 ALTER TABLE `works` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!50606 SET GLOBAL INNODB_STATS_AUTO_RECALC=@OLD_INNODB_STATS_AUTO_RECALC */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-21 17:29:00
