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
INSERT INTO `items` VALUES (1,'Coleman sunrise 2P GO TENT',2155,431,6,'�\��\�\0JFIF\0\0\0\0\0\0�\�\0�\0		\n\n	\r\r\r \"\" $(4,$&1\'-=-157:::#+?D?8C49:7\n\n\n\r\r\Z\Z7%%77777777777777777777777777777777777777777777777777��\0\0�\0�\"\0�\�\0\0\0\0\0\0\0\0\0\0\0\0\0�\�\0H\0\0\0\0\0!1AQaq\"2����\�#3BRr��CS�\�$b���45�\�\��Dc���\�\0\0\0\0\0\0\0\0\0\0\0\0\0�\�\0!\0\0\0\0\0\0\0\0!1QaA2\"�\�\0\0\0?\0�\�D�@��M5�Iϖ��hR\�+�\�\n\�ԋ\�cJjq�\�z	<<�*b�\0_G�u*�\0䌎\�\�Q\�[�Y�\�+\�#f\�O�\�֢\�.I\���I�iL�\�\�l��4o�\�3\�KB�2��\�M\'\�5�m\�K\'\�4�;	d,UG���H�w\�\\z3�\�\�M����\Z�\�6�\0���[i%\"Y�\Z��\\Q�\�[\�\�n\'��i?9��D\��\�?9��wr8N\���\�}�>U�c���m=ê�fCTɯ2C$�\�@�\�\�S\�1v<ۗ�J3T��²j�\�\']J��Q\�\�\�\'�<��\�Xԕ\�.��;$\�k���6\�\�y�\0�/\�5`�\�\��\�T[�l�\�\�\�$��|�t��\�\�.L6\�^I��\�s\�=���J2�N;*\'%EFTε\�ˌ\�)\�Ǧj\�(�_.����\����\0�\'\�5�~iG󚝴&YSw�s\�+\�+�7��mFk<J\�\�\'\�Ym#Q�_\n�lQ��x��ѿ�,�\�đ6A\�i�ծ\�����guC-�\�B\�c*�ed|�\�\n����	\�\nRil\�\�2**�#�Y\��U4\�\���uʳ\���;\��q\�\�*a<q��K��\�ƀd�\�E�u�Sm�\�3�����϶�Y�X�\0�b!\�	�aաb\�op��.�\0n+\\Wz\�||�֤\���\�S_�o~ޕ\�_�s�\0UW/�4\�\0�;Ș�<L�\�ע\�\�ڌ8E�\0\�ɲ}����-\�}\�`F\�0ޣ;�i���+\��w\�[ 	��\�Ѹ�\0��\�i:���\�\� qg�\��xW阧Y�<Ea����\Z\�\�q���\�l�\� Q�rNw��}\�zn�\�2\�jXA)ߔ\0\�8R5��u`s$e�>�\���$م\'p\�j@�G\��¨\����\0�ݜ\�J�ɯ�kI�OL�\�c�H\�j�*G\'\�º�q�\�֍\�\�M^�c~\��w\�\�7\�c}XIf%�O:\��n\�i$�\�\��z�˗\0�|\�qQ\�1f$�yՊ��湎�T�%\'!ɵ@�S�\n��3�FsR+\�]\�q�\�P�|\0\�p;k�υX��ʜ\�\�(\�H���1��\�\�W2O0�$,\�p�S��\�\�{K�\�e�ǤFD}\�\�[�]=.\�nE\�\���{�W�-x��K\r>��!�(��1G/f.M�-�\�W���\rvvʶ�\"y��0�(\�E\n�\0Sݜ\�\��\�\\�:X�\0�ʪx\��l}B���VY��\0t�\�y\�!��\�\�8\�k$�\�~�|G�\�x�R\�><i[l\� q�q�\�y��	\�ERd�N��<��d\Z9,�\�4*\�~�\�{\�,0f�;}%\�\�HJ>ċ�S��9�>4:�\�.\r�a\�7�SV\rZBֈ�-���9�\��!�a�;�\�\��\�vm�q�a�R8��trI���S�1\0��\�u�k�ʐW���n�1\�u9\�1R8\�\\�tJtVEq��]�	\�q�~J�Ps\�\\v\�-�ZJ\�\Z.�`\��\�\�&�����Y\�,X�5+�\�%\r\�G`&A\�.oo�`D�M�\�*�$vW��_N�\�\�l\�K�u\��\�NN��>�\�B\�|�䫹?C��{\�\�\���\�Y�yh�\�@C3&\�\�p\�NwNT(������\�tهP�[h�f�AŘ���jL\�K3q*����\�\�\�8\n\�\�嗆\\\�	H�kpf�_mL>{�t�\�=�2l\0�>\�\'\�\�\�DeԞ\�x\�W��:�F��[Ƈ\\>\�\�o%�m(���h�i\�	\�+M(\r#c��Rb\���\Z�\�-\�8\�Y�\�ճ]\Z��0C\nO \��\�\�?�k\���]\�\�+=��\�)jږ��	\�d\�?3�UK�\�m(�		r1�ҝ\�ǥB�F�F���u�0d���l���p�(0wQ)�\Z{kq+\�`$�O���VS_�I�1TS�0pxԛPgQ�w\0�7���\�\�\"Q���5SI©I?	���v�l\�e�\�z\�r2_m]��\�Ƥ�c�\�Mcb3FM�F��ֱOl�\�\�\�NU�\��hD�<�R��-�H|\�ݷ�\",\��\�\�\�P��.b1�>q��d\�a(�Q\�R*�Hb�aן&���{k�Ή�[(R\�	8\�C�m;�\�],U	P\�Yn9\�ʱ3\�}�2s�\�\�	�M����P9�]R`Y�\�\"a�֮��\��PY�\�y\����r�G�b��\�r@o\�i�\"�3\\�ۡ�\�\r��[ģv�lzM\�\�Z�ԩl&����p\'���\�r\�\���I�}A�;\�է�\�\�\�=�؂\�h��*F\�\r��\\Զ2r�,Ob��X\�K�cl�HRwv\��2>� ��\r�g�^�e�$��᯺�bLB)�[\�a�\�\�#���\�\�\�h��joH\"Yq\�mg��\�G��\�\�vE\�kx�\��\0\�Y�J%�\�(|�GX\�v�\�vO᣶G�\rwcҠ�Dd\�cP~�)d\�vk�\�#\\���9�\��_\�Y�$\�E\�ۅ]\�\n��-�R�\�(\����\�K�n\�V�8\�\�\�v��^¶\�T�3q\�`\�vwT�\�\�e\�H��\�a�B�GV\�\nͧ_M,{/6\�66\�\�\�U\�fr�\�\n\���K�XU�4�d�w\Z�\�9\�X�䍃��6�<\�o�l���@3D�j�e�uVI\r�,\�Sr�\�O3\�Wu�wb�N�\�#���2�G�\�\�[gѦy�\�1�\�8\'�Q�\�\��\r�D��l�Yz7ʁMz#\�Ʉq\�I\�MGB����Oʄk\���9�\�R#�N\0<	\�T�>4:�\�\�*K�۟\�\'��\��=y�Ư)WRp>\�\�_X^��H��cd/Ռ��h\\�|@�:ѯ�b�O�\���:�XD1,h0�\0�R�A�Q�\�\�\0����;\�g��jW�Yll\"��m�A\'ª\�Ik(ݽ&%��$\�z\�\�\���\'�\��3Vi\�yx�}c\�!\'i�<r�V{��\�\�є\�\�\�\�\�q��\�b\�P6=UTj�hʫ�cd?V(Ϋ�D����\�[Q�E\Z\�?\��w���c�����e� q\�ΣjcK\�x\��ؙ3�\Z��$�a���Uۢ�Ͳ�#�{\�\�^���WP�k9ʳšF��{�Z�˜z\rĊ�}J�[��\��x\Z򻍗8#���K\�\�8\n�+�3\�:��#~\��hKU!F7vѭf4w�WP\�~\��E+З�[��ۍڮ �=\�-NV�m��\�\�\����z���\�\Z��Q[\Z�$\��5L��\�$�ݦpY\�;en�v\�B�<\�L,j��QG\n��\�\�*\��A, \�mp��f�ǯ�\�\��\�R6��\�\�\�&�\�!�Hr\�6 ����\0\�Al\���x��A\�+�W��\�a\��kq\�2Fbdq�X`V��\'�\�m#��;E(\��,\�\�\Z���\�ۀ3�ҁ�$�:��q�\\Hz؏V_\'սc�/7B��\0�7�G�\�g�u:�R.\�3o�K�M�޻��$�a�t+G�\�`�v\�\0�\�1Cn����{�P䅘\r�`c�l�7T\�j\�wZ���\�\�\�\�8\�0?\�\�Z\�F�\�x\���\�q\�\�j�u�1B�wg�\�ʊ��}�\�\�0;8ẳ2\r��U>hLg\�Xd8ߜ\�a�`6z�ܼ\�Ж��\�\�tr\�\�\�S\�1\�\0W��^(Ǣ@>�[�\'O(\0�P�Ge0\�lM��N\��Q,鷃���R�x�B4�q\�L�ҷ�Vy\r4�ي\�\�}\�8\�\�A\�\�\�q/���V\��T2\�\�5,�	�2�#\�i[8��\�\��)�xنq\���5�\�I�\�t�Vm�\�\0;�н/�\�\\]\�ߕǩ�S�\�<�1\�\�\�2\�#;��\�\���Ũhʣohc�\Z�\� �3n�\�ָ\�C:ǌ�by\n\�\�\��x�)\�ƺ�)<9vP��Q\�~�d�s�xV0S)\�vk��DV5���H��\�A4��U IO\�V\�ߏq�jG\�om\n\�6 \�\���\�\�\�HD�r�ʌ/�\�\�-i{2$۔\�p\�\n\��\�ʎb�\�,mn�*��\�����d�r/zݜ�fe;��_���m%;JH\�2x�U��|\�q��PS\�TGO\�ṷ�qs �\�\�\0�x�UgFE\�z\�\�<\�\�\�\�z��\�n\�\�ZJ�\�\��T|+DZV��\�+�>U�b�K�%\�K��wQ\0\�\0\0�9\n��V\�D^\�ȧl\r�\�c����)k\r��$\�F\n8�����ب\�?�mVd�I\�<�(�\�Z�=�1m\n��=J)Zi2��V+��\�W<x\�\nz\�{|m\�5�ym\��+Yq�p��\�P�ʹd��\�>=F\�\�z�Z\�yV[�2\�t+4Qȧ�e���L���X\�\\\�x\�`�F��If=U�\�H�\�\�=�\�}НpLp5�v\�c�P6\�,��\�k\�q⒪ȇ\�CCeLaMр<9\�Y]c#=��s�t�\�X���\�Bcoa\��\�	\�/�\\�CN��\�m\�h\�3SFJ�<�ٚ�\�.6�4��͸Pu+w�%X\�\�8aF\�\�-�hFI#k�Ƿ�d�\�;���ba��ϫ�\\l\�V&� ��a��V�\�BKq\"3�,��\��\�.�\�\�$v\�\�p�R�$m��+\"�\n\n��w�\�\�6\\[ǿxP2	4\�R\�\�\��MVG~m-\�\��#y���\�ZDe[d�\��\�\\�k¯�s�X�\�q\�\���76�̹#\rɇk5�Su\�\�p\\�9\�{\����&|n>\�n�v\�!��\�Z\"\�n\�.$^�f7}�nx�\nf\�3\�\��y!�\�g,21��%c\�-�R\�\�ʞ*èܱm�\0\�#�,4\�NΨRD,���qu���#�\�{jq�U��|��D�\\�\���me♭\�\�U�\�Ã�?i~>\�T�V�eq՝�ǧVM��V \���v\Z�1\�CSa\�R\Z�w\�5�I�R\�\�\\�����`���6�k�n o	��jm�Hp��y\�jx��$\�\���\�\�\�\�Y\�_���\��\�\�\�\�PmU���\�k�\'ы�0\�\�m�]���|	?Fc��ڣv�Vu�#\�H-�\�3R��V\�\��\�?њ潌�j�� ~.)\�\�\�\�\�|H�W\�\�Sȟo���6!\�w�(d\�R\�\��\0\n\��P�@.�x$y�\�.]!�X\�\'���&��\��J�_���	��m�N�}\�\\�eu,s\�INMF\�W#%ُ�`�\�\�\�H��\'q\��V\�f�M�0\�%;\�4:�n\�sR�A�O���{k؏\�\�ց\�CU<\�	�#\�Ȅb���\'l\'Ò\�\��ҌN�\�O�\�+3�V8��WYT��\�~\�l��\�d�e�\��\"�\n-rGnݺ��W�`�wj\�oo\�11��h(�\�R\�E�ea� �\"�ȂOIT��N��\"f�cv�Rh؂���\��\0(�%���QV���z\�=���S/ΛaH\� El`x ݟ�ڭ,�}�u���ߠ�(h>\�|V�b�\�� �\�I��\0����V�m�\"��\�R,�\�7��U��\�~5�\rl��_l�{\"�뛐A���\�\�\�\��\�Z*�\�\��Fj]K�\�?)CJ\�\�;U��\�F�\�\�#\�\"��@���O�b}±�\���\�o��\�\�u�T\'ߊ�١��w6�T/#\�k��\�\�_���J��� �n��\�D������\�ƃ,ݕLRAu�2�!\�ܫ%�I,f]\�h�0C��\�\�\�ڪ�Ѳ��4��kҭ�ߛI�\\\�&>ww}6\��rA<s\�˰Ãb��\n+�_\�:\�J|\�|\�\�{+���\�\�S��\�	$�B_�WU�T�\�/�J>�3�)\�U\�<h<�^[gt��\�\\\�\�8�UO4�\�H\�\�\�\�ٵ}:/���_�d���Lc��[�)op��\�i	�K\�\��0\'^\�<{�Y\�酿\�\�e?���Ҹ\��\��fcP&�_���%,\�Q�\�	�\n\�\'J\�\�H�ΩqH3C�5iN�jO�\0�\��(�\�Yfկ�j�oS�\�\�d�#И\�2\\�\�O\Z�\'�߯��\�K#�&&�H\�\\_�\�z\��zn7�繳t�N�w\\\����l\��\�\�K\�K�q1\"\�\�\�\0p]����\��$\�=H;nN�\�/�\�߀>5�^��\0\��I�(�i\\��\0\�KM6�����\�t^(�\�7+$��F�\�\�\nY�1\�w�*�I\�B\�&�oB(S\��k�\��\�_\�L1hQ�\�՝ƍ�Y\�Z\�\"��lF\�Dg-�\�Y�K�\�ѫ�\�5N�\�,\�X-I\�\��\�\���;�\��\�\�8��M��),Ndc�\��i\��\0+�Y\�\�4m�W|p\�Ul�\�_h\�2K�==^\�m \"r�q_<�O<0\�D�#E\�θ;\�P�POP\\{ў�\�T+��\�]>\�]\�\�+rC�I\�H\�sAmf1�\�\���R\r}lqs	\�}�bM\�\�A��ʫ]�J�\Z\�\0�韕c}.s�\0�P�D��㶼�����\�k\��M�\\ɡ�*�g(\�$��0�v�\�\��v�T�7�9;��qz5s���\�Oʬ\Z����\�?*� _jy�\�ܽ��\���\�\�\�\�@=g\�Ftjö6G\n\�G<\�7���~�i�U\�ѫ�����Oe\r\n�D��=u\�j\�\�����Oʭ�FZX��~Tv٨K[>�쩋.\�i\�ty�ڏ��Z�~]O���lhJ[/\�\n+6�-ޙg=�{~IA: \�\�;�c\��\�j��a\Z�\�a��\�\�q,�r/Ge#\�*{�J[F;�^�\���i֚=�m,��\�\�71p\�G\�z\�}�A\�z\�?�I��\�V,Z\�\�M�{\�\�ѱ%c{�\�ӛ�\�����\�r�X���\�\�VTnm\�\�7�i;Z\�纻�\�\�@\�d��ٔ�c��*\�-��\�4ᱫ�\�\�9�\0\�j�F�Q��\0�Ԯyh\�:U\�}7K���C\Z\�E\"VE�e�8����~�F9�\�5\�] �\ru~�\�5\�\�\��N\�N\����8=�\�R\�jWK�\�wQ7lw.(>�k\�+,cZ�\��&\���U�e-Q�hL\��r��W�1X\�H�\�\\o\�ER3͏\08�k<��s\�,�\�(i��\�\'8�+\�?RԂ��Ɵg\�\�\'v\��\�\n7E\�\�r�G������6\��\�',15,1);
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
