SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

<br />
<b>Fatal error</b>:  Uncaught TypeError: Argument 3 passed to PhpMyAdmin\Export::exportDatabase() must be of the type string, null given, called in C:\xampp\phpMyAdmin\export.php on line 526 and defined in C:\xampp\phpMyAdmin\libraries\classes\Export.php:646
Stack trace:
#0 C:\xampp\phpMyAdmin\export.php(526): PhpMyAdmin\Export-&gt;exportDatabase('sultans_baz', Array, NULL, Array, Array, Object(PhpMyAdmin\Plugins\Export\ExportSql), '\n', 'db_export.php?d...', 'database', false, false, false, false, Array, '')
#1 {main}
  thrown in <b>C:\xampp\phpMyAdmin\libraries\classes\Export.php</b> on line <b>646</b><br />
