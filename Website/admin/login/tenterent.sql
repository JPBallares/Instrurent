-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: tenterent
-- ------------------------------------------------------
-- Server version	5.7.14

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `account_type` enum('a','c','sa','sp') NOT NULL,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'user1@email.com','user1','qwert','c'),(2,'admin@gmail.com','admin','admin','sa'),(3,'admin1@yahoo.com','admin1','admin1','a'),(4,'sp@gmail.com','sp01','sp01','sp');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(45) NOT NULL,
  `admin_contact` varchar(45) NOT NULL,
  `accountsid` int(11) NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `admin_id_UNIQUE` (`admin_id`),
  UNIQUE KEY `admin_name_UNIQUE` (`admin_name`),
  UNIQUE KEY `admin_contact_UNIQUE` (`admin_contact`),
  KEY `accountsid_idx` (`accountsid`),
  CONSTRAINT `accountsid` FOREIGN KEY (`accountsid`) REFERENCES `accounts` (`account_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'marc','09653346612',3),(2,'jan rei','09502878134',2);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `address1` varchar(45) NOT NULL,
  `address2` varchar(45) DEFAULT NULL,
  `contact_number` varchar(45) NOT NULL,
  `accepted` tinyint(4) NOT NULL,
  `accounts_id` int(11) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_id_UNIQUE` (`customer_id`),
  UNIQUE KEY `contact_number_UNIQUE` (`contact_number`),
  KEY `accounts_id_idx` (`accounts_id`),
  CONSTRAINT `accounts_id` FOREIGN KEY (`accounts_id`) REFERENCES `accounts` (`account_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'klint','chinayog','asdas',NULL,'09993313896',1,1);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_type`
--

DROP TABLE IF EXISTS `item_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(45) NOT NULL,
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `type_id_UNIQUE` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_type`
--

LOCK TABLES `item_type` WRITE;
/*!40000 ALTER TABLE `item_type` DISABLE KEYS */;
INSERT INTO `item_type` VALUES (1,'bag'),(15,'tent'),(16,'grill'),(17,'pickaxe'),(18,'shovel'),(19,'hammer'),(20,'fishing rod'),(21,'axe'),(22,'thermos'),(23,'table'),(24,'chair'),(25,'sleeping bag'),(26,'lantern'),(27,'blanket'),(28,'pillow');
/*!40000 ALTER TABLE `item_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(45) NOT NULL,
  `price` double NOT NULL,
  `renting_fee` double NOT NULL,
  `stock` int(11) NOT NULL,
  `item_image` blob NOT NULL,
  `type_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_id_UNIQUE` (`item_id`),
  KEY `type_id_idx` (`type_id`),
  KEY `provider_id_idx` (`provider_id`),
  CONSTRAINT `provider_id` FOREIGN KEY (`provider_id`) REFERENCES `service_provider` (`provider_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `type_id` FOREIGN KEY (`type_id`) REFERENCES `item_type` (`type_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Coleman sunrise 2P GO TENT',2155,431,6,'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0„\0		\n\n	\r\r\r \"\" $(4,$&1\'-=-157:::#+?D?8C49:7\n\n\n\r\r\Z\Z7%%77777777777777777777777777777777777777777777777777ÿÀ\0\0¾\0¾\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\0H\0\0\0\0\0!1AQaq\"2‘±Á\Ñ#3BRr’¡CS‚\á$bƒ“ñ45²\Â\ÒğDc”¢ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\0!\0\0\0\0\0\0\0\0!1QaA2\"ÿ\Ú\0\0\0?\0º\ÌDò©@šµM5ˆIÏ–·¯hR\Î+¸\Ï\n\çÔ‹\ìcJjq¶\áz	<<ò*bı\0_Gşu*…\0äŒ\Ê\àQ\Ù[©Y»\ß+\Ú#f\íO„\ßÖ¢\×.I\ÅÁõIıiL \ãŠ\ìl©Ÿ4oÁ\Î3Â‡\ÇKB¦2´ò\ìœM\'\ç5šm\ßK\'\æ4±;	d,UG€ªƒHŒw\Ö\\z3˜\Ò\ÓMŸ®—ó\Z¬\Ï6ÿ\0¦“óš[i%\"Yƒ\Z”\\Qü\æ·[\Ğ\Æn\'Àúi?9¨ùD\Ùú\é?9¥ówr8N\Õ¾º\ë}ª>U°cš›¹m=ÃªfCTÉ¯2C$²\Æ@¥\î¹\äS\Ö1v<Û—…J3T¡ôÂ²j·\×\']J©÷Q\È\È\î\'ş<¿œ\ÖXÔ•\Ï.¡•;$\Úk¦’²6\Ë\Òyÿ\0/\ç5`\ã\Ëù\ÍT[Œlù\Ù\İ\ìª$|ıt¿œ\Ö\è.L6\Ì^Iœº\ãs\Ç=µƒªJ2¼N;*\'%EFTÎµ\ÌËŒ\Í)\ÉÇ¦j\Ï(›_.¨¯±¿\ë¡úùÿ\0\'\ç5ñ~iGóš´&YSwšs\í+\èš+§7“ŸmFk<J\Å\ã\'\ÅYm#Q“_\n”lQ²§x¬üÑ¿»,\ÜÄ‘6A\ÏiªÕ®\ìø‘ÀguC-µ\ËB\ëc*½ed|Â \à\nµˆ¬ó	\ã¸\nRil\Í\Ù2**#Y\ØğU4\ß\Ñş‰uÊ³\êÀ¨;\Òq\Ú\ß*a<q˜´K±²\ÓÆ€dó\çEuûSmŸ\ì3£´˜Ï¶ŠYôX¹\0¼b!\Ş	§aÕ¡b\Éop§´.ÿ\0n+\\Wz\Ä||«Ö¤\çô©\ÍS_öo~Ş•\É_ğsÿ\0UW/û4\Ô\0ú;È˜ö<L¾\ì×¢\Ù\ëÚŒ8E¶\0\àÉ²}¢‹Á¯-\Ê}\Ğ`F\Ò0Ş£;üi»¨ñ+\Ïöw\Ò[ 	±©\àÑ¸ÿ\0«ƒ\İi:‡û\å•\Ä qgŒ\ìûxWé˜§Y£<Ea½·…ó·\Z\ï\âqŠ«ó\Ôl‚\Ø Q’rNwŠ”}\ãzn½\Ñ2\çjXA)ß”\0\â8R5öu`s$e“>’\ï¢¨$Ù…\'p\Şj@ğ­–G\Ö™Â¨\Èö©ª\0ñİœ\ÛJ•É¯†kI‘OL¦\ËcH\ÜjÀ*G\'\åÂºŠq¼\äÖ\Ö\ÂM^c~\àÀw\×\Å7\íc}XIf%O:\èó¶¸n\ï¥i$Á\í\èúz°Ë—\0|\ÌqQ\Ë1f$’yÕŠ§øæ¹üT¨%\'!Éµ@öS²\n²‚3FsR+\á]\Æqš\ÉP¶|\0\æp;k˜Ï…X¤©Êœ\ê\ì(\ÓH¨€³1À´\î\ÌW2O0Š$,\ìp S¦‡\Ñ\Û{K‰\Õe½Ç¤FD}\Ã\ç[´]=.\ßnE\é\Æó÷{ªW·-xö‰K\r>÷!ı(“ø1G/f.M´-\ÂWøŸü\rvvÊ¶\"yŠ¨0•(\ÅE\n£\0Sİœ\Ù\âü\İ\\½:Xÿ\0§Êªx\Èûl}B‰˜÷VY’š\0t‡\Öy\ç!·\ê\Ó8\Şk$¼\è~›|G˜\çx¢R\Ì><i[l\Ç qÀqğ­\Íy°Š	\âERd´Nùò<‚¤d\Z9,¡\Ó4*\ë~ñƒ\ë¤{\İ,0f·;}%\ä\ÔHJ>Ä‹†SÀò§9—>4:ö\Ñ.\r•a\è¶7ŠSV\rZBÖˆ¡-’ù¸9¨\ÉÁ!a†;Á\ä\Ş³\ÊvmŒqªaÀR8‘trIª „S»1\0šù\âu—k¬ÊWùön©1\Ùu9\Ï1R8\Å\\£tJtVEq„›]	\âqŸ~JPs\Û\\v\Ù-ZJ\Õ\Z.™`\èı\Ù\Æ&‡õ«£÷Y\ß,Xğ5+«\ë¸%\r\ÊG`&A\ïª.oo®`DšM\Ì*»$vW‹º_Nø\Ç\ál\ÚKu\Ñ‘\ÜNNóó¦>Š\èB\Í|¾ä«¹?C»{\å\í\ì¡ı‚\çY˜yhŒ\Û@C3&\â\Äp\éNwNT(À€«·’\ÉtÙ‡Pº[hšfAÅ˜ğ‚ÁjL\ÒK3q*±•ˆ\ß\İ\Ü8\n\Ô\íå—†\\\æ	H‡kpfø_mL>{tñ\Ó=´2l\0ò>\Ğ\'\Î\ã\ßDeÔ\Òx\â‡W»™:F¶[Æ‡\\>\Ô\Ío%·m(§şhği\Ö	\æ+M(\r#cô©Rb\Ò›¤\Z€\Ù-\Ñ8\ŞY”\çÕ³]\Z¦¿0C\nO \Æó\Õ\ç?şk\Òú¤]\á\à+=À«\È)jÚ–¸„	\íd\Ï?3úUK«\ßm(’		r1ŸÒ\îÇ¥B®FóFƒˆ¾u‚0d‰ö¸l¡ûpº(0wQ)‡\Z{kq+\Æ`$ÁOœVS_¢I­1TSœ0pxÔ›PgQ›w\0®7“šû\É\î\"Q·¿‡5SIÂ©I?	¢–vl\ÄeÁ\Äz\êr2_m]—»\ßÆ¤¸cŒ\áMcb3FM¿F¨”Ö±Ol¡\Ğ\ê\ÖNU†\ìühD‘<õRñû-H|\èİ·¡\",\íŒò\Î\â\éP¹.b1¿>q¶´d\ëa(üQ\İR*ñHb”a×Ÿ&¢£€{k¡Î‰Á[(R\Î	8\îC¨mÍ¾·\Û],U	P\ÛYn9\ÇÊ±3\í±}2s\Ê\ã	¹M£¤¢”P9õ]R`Y¡\Ç\"aÖ®·º\Õî§†µPYÂƒ°\Ãy\Íı¹¨r•Gøbœº\år@o\ïi‰\"²3\\Û¡¾\Å\r…ª[Ä£völzM\Ì\ÕZÔ©l&™º¸÷p\'‰õš\är\È\í¼ş•Iú}A¤;\ÖÕ§‰\Ş\Ç\Ü=µØ‚\Ëh¼‘*F\Ê\r–\\Ô¶2r§,Ob®™X\ÜKŒcló¯‘HRwv\î¬ü2> ” \rŒgñ^e$„Ÿá¯º’bLB)ª[\ãa¥\Û\Ê#«‚\Ø\å\àh´¶joH\"Yq\émg˜©\àG¶ƒ\É\ÒvE\ÚkxÀ\ï˜ÿ\0\ÛYJ%’\â(|•GX\áv„\ÇvOá£¶G®\rwcÒ ÷Dd\ïcP~ª)d\Ævk¸\Í#\\ô­ˆ9´\åü_\éY³$\ØE\ÆÛ…]\äœ\nºò-›R‰\é(\Ê÷‘¿\áK¥n\ÔVø8\ã\Ö\ïv««^Â¶\İTø3q\Ì`\ãvwTú\Ì\Ğe\ÜH—\Ña‘B®GV\ç\nÍ§_M,{/6\Î66\áƒ\Ã\ÙU\ê“fr´\ã\n\Üş•KşXU–4§d€w\Z¡\ß9\İX­äƒõ6’<\ìo«l´û½@3D¾jœe›uVI\r›,\çSr‰\ÊO3\ÛWu wb¨N\ß#«©„2G\Ï\Ù[gÑ¦y\ã1€\Ç8\'úQŸ\à\áú\r¾D¸Œl°Yz7ÊMz#\ÊÉ„q\ÅI\áMGB¸ûñûOÊ„k\İ•’9ú\ÔR#¾N\0<	\İT¹>4:”\åŒ\Ä*K¨ÛŸ\ß\'¶¨\Öú=y¦Æ¯)WRp>\Ş\Ã_X^¨·H¤…cd/ÕŒ¿h\\¦|@­:Ñ¯¯b·O¶\Ûû‡:õXD1,h0Š\0°RŸA¬Q\Å\ì¹\0©öŸ…;\Åg›ûjW…Yll\"…¤mÁA\'Âª\ÓIk(İ½&%‰$\Õz\Ã\Ó\Ù÷„\'´\ïı3Vi\äyxŸ}c\Õ!\'iŠ<rÀV{˜·\Ê\ÈÑ”\Ù\ä\ë\î\Íq¬ƒ\æb\ÜP6=UTj£hÊ«øcd?V(Î«¿Dƒ¸¯¸\Ğ[Q˜E\Z\Ô?\à‘w©—ùcô…ñ‰ƒ¿eÀ q\ÇÎ£jcK\ëx\âÁØ™3\Zºò$˜aƒŸ³UÛ¢­Í²¨#¯{\ë\É^¯¡ıWP·k9Ê³Å¡Fô°{¿ZòËœz\rÄŠõ}Jò[‘–\æüx\Zò»—8#úôK\Ó\Ï8\nñ+š3\Ò:´°#~\ã»ùhKU!F7vÑ­f4w°WP\Ã~\ãøE+Ğ—†[¦ÛÚ® =\Õ-NV˜mœ\Ø\ì¨\ÛÁ¾•z±±”\å¼\Z«Q[\Z…$\à5L˜„\ì´$–İ¦pY\Ú;en–v\ÉBó<\ê»L,j¸ôQG\n´¸\ç\î©*\ÊõA, \ëmp«œf°Ç¯«\Ã\Öõ\ÙR6»\ì\ï¬\İ&\î!†Hr\Æ6 ªŒÿ\0\éAl\ÅÀ†x¤†A\ç+®W û\Åa\Õ°kq\Ë2Fbdq´X`Vù‘\'‰\âm#‚¬;E(\ÛÁ,\Ó\Ç\Z‚ı\ÔÛ€3úÒ‚$µ:–•q§\\HzØV_\'Õ½c­/7B·ÿ\0¾7ùGş\êg”u:´R.\å3oûK½MªŞ»ùš$·aüt+G²\Ò`‹v\Ó\0í¿™\Í1Cnª ³’{¸Pä…˜\rÀ`clŒ7T\äjÂˆ\ÏwZ¥³\í\Ã\Ê\Ø8\à0?\æ¢\ĞZ\ÙF¢\Üx\ìõ›\éq\Ì\Òjòu„1Bªwg‰\ÏÊŠÁ‰}¥\Æ\Ã0;8áº³2\rù«U>hLg\ÕXd8ßœ\×a‚`6zıÜ¼\ÚĞ–÷\Ï\å tr\É\Æ\ÉS\Ä1\Ï\0W°‰^(Ç¢@>ú[†\'O(\0¶PôGe0\élM„N\ÎúQ,é·ƒ–›­R¨x£B4øq\ÙLÒ·³Vy\r4‚ÙŠ\è\î}\Ù8\á\ÛA\î\ï\Äq/ş”V\äúT2\è\ï5,¤	¸2ú#\Öi[8½´\ï\Ëü)’xÙ†q\æÀò5†\ãI\êtšVm¤\Î\0;·Ğ½/Á\ç\\]\ïß•Ç©­S¬\Ì<–1\Ì\ä\Ó2\è‘#;¢\Ï\é“šÅ¨hÊ£ohc†\Z—\à Œ3nÀ\ìÖ¸\ßC:ÇŒ•by\n\æ\Õ\Ç„xŠ)\×Æº’)<9vP²Q\Ä~µd±sxV0S)\Çvk DV5ÁH²©\ÆA4¨U IO\î¤V\ãßq­jG\Şom\n\Ö6 \â\ßŸ…\Ñ\Ú\ÊHD—r•ÊŒ/\í\Í-i{2$Û”\àp\í­\n\Ùº\ÆÊb‰\Å,mnò¤™*¥ˆ\Æ®²…¦d·r/zİœ‰fe;ø_òş´m%;JH\Æ2xU—ö|\Åq™†PS\íTGO\Óá¹·qs ¹\Ù\Ù\0®xUgFE\éz\ë\è<\î\Ş\ê\ìz¬€\áœn\İ\ãZJ¶\â\×ûT|+DZV\ï+ù>U´b‹K£%\ÎK´…wQ\0\î\0\09\nŒöV\ÑD^\ŞÈ§l\r³\çcˆõŒŠ)k\rŒğ$\ÑF\n8¹¬ŒÁØ¨\É?§mVdóI\Ú<û(ú\ÚZò‰=•1m\nğ‰=J)Zi2ı®V+°\íW<x\ï\nz\Â{|m\ã5Œym\Ì–+Yq’p±±\ÍPšÍ´d¤¯\Ô>=F\É\Íz³Z\ÂyV[2\Ît+4QÈ§ˆe¡¢¬L´»‚X\Ã\\\ãx\Í`F¿šIf=Uº\îH¾\Ñ\ï=”\Å}ĞpLp5³v\îc÷P6\è,–\ï§k\×qâ’ªÈ‡\ãCCeLaMÑ€<9\ÖY]c#=‚£s¢tŠ\ÕX‡³¼\ïBcoa\İú\Ğ	\ï/­\\CN»·\Ùm\Ìh\â3SFJø<³Ùš¶\Ê.6š4ÀûÍ¸Pu+w®%X\ï\Ù8aF\Ö\é-ÁhFI#kˆÇ·•d˜\Ù;¤®¢ba¸¨Ï«•\\l\ÏV&ò• Œ¨aŒöV¿\êBKq\"3•,«Œ\à\Ú.¤\ä\í™$v\æ\ãp•Rƒ$m¼”+\"…\n\n“w\Õ\İ6\\[Ç¿xP2	4\æR\è\É\ÉûMVG~m-\Ó\Í±#yÀùš\é†ZDe[d­\îğ\İ\\kÂ¯’s²X‚\ìq\å\Äûª76‘Ì¹#\rÉ‡k5´Su\ë\×p\\…9\Ü{\êøù½&|n>\Ún­v\Ê!»½\ÙZ\"\Ôn\í.$^¯f7}¶nxŸ\nf\í3\Ù\Üy!•\ãg,21¾‰%c\è-ûR\í\íÊ*Ã¨Ü±m†\0\ã#…,4\ŞNÎ¨RD,ü»quˆ‘‰#‚\à{jqøUı©|­ºDÁ\\Œ\ã«ômeâ™­\æ\ÙU”\íÃƒ»?i~>\ÚT‡V‡eqÕ†Ç§VMŒ‰V \Ãµ¼v\Zš1\èCSa\ÛR\Z«w\Ò5ŸI R\Ğ\Ş\\Á´¾„›`ı†µ6»kön o	”üjm•Hpı¬y\Ôjxú$\Ë\Ò—\Ï\á\Ş\áY\ß_³Ÿó\Åğ\ê­\É\Û\ÛPmUşøõ\Òk—\'Ñ‹ó0\ì\Õm«]°ô‘|	?FcˆüÚ£v­Vuñ#\ÛH-¨\İ3RŸV\×\×÷\Î?Ñšæ½Œñj­® ~.)\Ê\æ\Ï\Ö\Ê|HùW\Æ\æSÈŸo­š6!\íwö(d\ëR\Ô\Ü´\0\n\ã›P·@.¶x$y¬\ê».]!…X\ï\'«şµ&¸Ÿ\ëˆ€Jš_ÀÁ™	¹¸m¦N¬}\æ\\Ÿeu,s\ÂINMF\æW#%Ù`š\î±\Ô\ÜHŒ§\'q\ÏúV\ìfÁMˆ0\ë%;\×4:ûn\ŞsR—A½O¢²©{kØ\Ò\ÃÖ\ÍCU<\Ñ	£#\ìÈ„b¯™\'l\'Ã’\Ğ\Û‰ÒŒN£\ÏO½\Ş+3©V8¡–WYTÁ\ä~\Ål‹©\Ädƒeú\Èş\"¸\n-rGnİºµ§Wó`wj\æ¹oo\Õ11¿h(¹\ãR\ÛE®eaŒ ›\"³È‚OITú«N¶º\"fôcvğRhØ‚¦µƒ\áˆÿ\0(®%•¿QV¶—œz\Æ=õ±üS/Î›aH\Â El`x İŸüÚ­,¤}»uõ“ğ¨ß ü(h>\Í|V¬bœ\æø ù\ÔIÿ\0úÀøV´m\"¹³\ãR,ƒ\ì7­şU°§\ê~5­\rlŸ»_l{\"¾ë›Aü‚¹\×\É\É\Èğ\İZÂ‰*±\à\ãùFj]Kó\ë?)CJ\í\é;U–¦\ÍF£\ç\Î#\×\"@­ºúOşb}Â±»\Õõ¬\Ôo‘¬\Â\ïuşT\'ßŠ¢Ù¡™±w6òT/#\Şk¸\ï¬\Ğ_½³Jˆ™ˆ œnÀª\ÛD‡®·…¦˜\ìÆƒ,İ•LRAu’2²!\àÜ«%·I,f]\Èh²0CŒ­\Ò\Ş\ÔÚªÀÑ²ŒŸ4ŠŠkÒ­¦ß›I¶\\\æ&>ww}6\é÷rA<s\ÛË°Ãƒb‘\n+¢_\ì:\ÛJ|\Ò|\Ã\Ø{+¼•œ\â\ÏS’ù\ç	$‘B_—WUùTƒ\Ñ/„J>3ô)\áU\É<h<ù^[gt‘¬\Ş\\\Ç\á8÷UO4\éH\í\â\Ä\ĞÙµ}:/¬¾·_ñd—¤ºLcıñ[ğ)op¦¤\Íi	¨K\ï\Òı0\'^\çº<{ñY\äé…¿\î\íe?‰€ùÒ¸\åğœ\ãôfcP&•_¥²°%,\ãQı\é	ø\n\É\'J\ï›\ÑHÁÎ©qH3C‘5iN‘jOÿ\0¸\Ùü(£\áYfÕ¯¤jòoS‘\îª\êdö#Ğ˜\Õ2\\Á\ÖO\Zş\'¼ß¯•ó\ÖK#ş&& H\ìª\\_¡\Øz\êúzn7ç¹³î¬³t‹Nw\\\ì»¤•l\Ñ­\ì\â´K\íK­q1\"\Ş\Ö\Ò\0p]˜ƒ²¹\È‰$\Í=H;nN•\Ú/¡\ïß€>5–^•ÿ\0\ÏóIı(—i\\´ÿ\0\îKM6½¼¹³Š\ìt^(­\åµ7+$÷òF¸\Ú\Ù\nY°1\Æw‚*—I\ÎB\ä½&»oB(S\Äñ¬²k—\ïû\Õ_Âƒ\ãL1hQµ\İÕÆ¦Y\İZ\Ê\"–½lF\ÛDg-¿\ÕYúK¦\ÃÑ«¸\í5N\Û,\ÏX-I\ä\Âò\Î\ê¬˜µ;·\Üó\É\ê8¢¶M·¥),Ndc“\êÁi\Ğÿ\0+¶Y\â\Ó4m–W|p\äUlœ\Ç_h\Î2K»==^\Îm \"r»q_<ˆO<0\ãD•#E\ÛÎ¸;\ÅP¦POP\\{Ñ¢\ÛT+»\Ú]>\è]\Ö\Å+rCI\àH\ÎsAmf1»\Î\áŠ¥R\r}lqs	\ì‘}ôbM\èœ\íAùÊ«]ğJ¬\Z\ß\0ƒéŸ•c}.sÿ\0§P«D©Àã¶¼ı·œ¶ó\Úk\ÒúM¤\\É¡õ*ñg(\Ù$ü©0ôv÷\ï\ÛşvùTñ­7°9;«”qz5sö¥‡\ÔOÊ¬\Z›œ‘Ÿ\æ?*« _jy¦\èÜ½°ú\Øüª\Ô\è\Ü\çƒ@=g\åFtjÃ¶6G\n\èG<\Ó7şœ~òiùU\ÉÑ«†¤‡ó•Oe\r\nD‡–=u\Ñj\ç‰\âŸœûOÊ­•FZX†~TvÙ¨K[>óì©‹.\âi\Ìty‡Úó•Z½~]O¬Ÿ•lhJ[/\î\n+6Ÿ-Ş™g=¼{~IA: \ß\Ò;«c\îø\Ïjœña\Z¹\Æa³ò« \Ñ\î¢q,¬r/Ge#\Ö*{¨J[F;±^µ\Ñş”iÖš=’m,¥¶\Ó\ã‰71p\âG\Çz\á¸}£A\Äz\Ø?ñIø\ïV,Z\É\ãªMş{\Ñ\ÜÑ±%c{¥\ÅÓ›«\Äıƒ—\Ër·X—•À\Ù\ÏVTnm\Ù\à7’i;Z\Ôçº»–\ê\ï@\Ñd¬ó’Ù”±c¦*\ã-»‰\í4á±«†\Ç\í9ÿ\0\ÏjµF®Q˜ÿ\0Ô®yh\Ğ:U\Ñ}7K±‰úC\Z\İE\"VE˜e’8©ô~…F9…\ï5\æ] ¾\ru~\İ5\í»\Ü\ÈñN\ÎN\Ú‘ 8=•\èR\ÙjWKŸ\ÚwQ7lw.(>£k\Ò+,cZ•\Ğğ&\áÁöU®e-Q”hL\èôr½ôW‡1X\ÚH²\Ü\\o\ÙER3Í\08’k<šŒs\Ï,³\Û(i¿›\Ë\'8¦+\í?RÔ‚‹ûÆŸg\Ñ\ë\'v\Ùğ\Ï\n7E\î\ÌrÀG÷˜üªôı6\Ñÿ\Ù',15,1);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_provider`
--

DROP TABLE IF EXISTS `service_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_provider` (
  `provider_id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_name` varchar(45) CHARACTER SET koi8r NOT NULL,
  `provider_contact` varchar(45) CHARACTER SET koi8r NOT NULL,
  `provider_address` varchar(45) CHARACTER SET koi8r NOT NULL,
  `accountid` int(11) NOT NULL,
  PRIMARY KEY (`provider_id`),
  UNIQUE KEY `provider_id_UNIQUE` (`provider_id`),
  UNIQUE KEY `provider_name_UNIQUE` (`provider_name`),
  UNIQUE KEY `provider_contact_UNIQUE` (`provider_contact`),
  UNIQUE KEY `provider_address_UNIQUE` (`provider_address`),
  KEY `accountid_idx` (`accountid`),
  CONSTRAINT `accountid` FOREIGN KEY (`accountid`) REFERENCES `accounts` (`account_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_provider`
--

LOCK TABLES `service_provider` WRITE;
/*!40000 ALTER TABLE `service_provider` DISABLE KEYS */;
INSERT INTO `service_provider` VALUES (1,'okimwa','09158776605','bakakeng',4);
/*!40000 ALTER TABLE `service_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `date_rented` date NOT NULL,
  `date_due` date NOT NULL,
  `amount` double NOT NULL,
  `approved` tinyint(4) NOT NULL,
  `cust_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `transaction_id_UNIQUE` (`transaction_id`),
  KEY `cust_id_idx` (`cust_id`),
  KEY `item_id_idx` (`item_id`),
  CONSTRAINT `cust_id` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `item_id` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-30 12:36:53
