<?php

// Security
if (!defined('_PS_VERSION_'))
    exit;

// Checking compatibility with older PrestaShop and fixing it
if (!defined('_MYSQL_ENGINE_'))
    define('_MYSQL_ENGINE_', 'MyISAM');

// Loading Models
require_once(_PS_MODULE_DIR_ . 'posstaticblocks/models/Staticblock.php');

class posstaticblocks extends Module {
    public  $hookAssign   = array();
    public $_staticModel =  "";
    public function __construct() {
        $this->name = 'posstaticblocks';
        $this->tab = 'front_office_features';
        $this->version = '1.0';
        $this->author = 'posthemes';
        $this->need_instance = 0;
        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => '1.7');
        $this->hookAssign = array('rightcolumn','leftcolumn','displayHome','displayTop','displayTopColumn','displayFooter','extraLeft','displayNav');
        $this->_staticModel = new Staticblock();
        parent::__construct();


        $this->displayName = $this->l('Pos Staticblock');
        $this->description = $this->l('Manager Static blocks');

        $this->confirmUninstall = $this->l('Are you sure you want to uninstall?');
        $this->admin_tpl_path = _PS_MODULE_DIR_ . $this->name . '/views/templates/admin/';
       
    }

    public function install() {

        // Install SQL
        include(dirname(__FILE__) . '/sql/install.php');
        foreach ($sql as $s)
            if (!Db::getInstance()->execute($s))
                return false;



        $tab = new Tab();
		$tab->active = 1;
        // Need a foreach for the language
		$tab->name = array();
		$tab->class_name = 'AdminCmsBlock';
		foreach (Language::getLanguages() as $language) {
				$tab->name[$language['id_lang']] = $this->l('Manage Staticblocks');
		}
        
      
        $tab->module = $this->name;
        $tab->add();
		
        // Set some defaults
        return parent::install() &&
                $this->registerHook('displayTop') &&
                $this->registerHook('displayTopColumn') &&
                $this->registerHook('blockPosition1') &&
                $this->registerHook('displayBlockPosition1') &&
                $this->registerHook('displayBlockPosition2') &&
                $this->registerHook('displayBlockPosition3') &&
                $this->registerHook('displayBlockPosition4') &&
				$this->registerHook('blockPosition2') &&
				$this->registerHook('blockPosition3') &&
				$this->registerHook('blockPosition4') &&
				$this->registerHook('blockPosition5') &&
				$this->registerHook('bannerSequence') &&
                $this->registerHook('leftColumn') &&
                $this->registerHook('rightColumn') &&
                $this->registerHook('displayHome') &&
                $this->registerHook('displayNav') &&
                $this->registerHook('productExtraRight') &&
                $this->registerHook('displayFooter') &&
                $this->registerHook('displayHeader')&&
                $this->registerHook('displayBackOfficeHeader');
    }

    public function uninstall() {

        Configuration::deleteByName('POSSTATICBLOCKS');

        // Uninstall Tabs
        //$tab = new Tab((int) Tab::getIdFromClassName('AdminCmsblockMain'));
        //$tab->delete();
        $sql = array();
        include (dirname(__file__) . '/sql/uninstall_sql.php');
        foreach ($sql as $s) {
            if (!Db::getInstance()->Execute($s)) {
                return FALSE;
            }
        }
        $tab = new Tab((int) Tab::getIdFromClassName('AdminCmsBlock'));
        $tab->delete();

        // Uninstall Module
        if (!parent::uninstall())
            return false;
        return true;
    }
    
    public function hookDisplayNav($param) {
       $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'displayNav');
        if(count($staticBlocks)<1) return null;
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
	
    public function hookDisplayTop($param) {
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'displayTop');
        if(count($staticBlocks)<1) return null;
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
	
	public function hookDisplayTopColumn($param) {
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'displayTopColumn');
        if(count($staticBlocks)<1) return null;
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
    
    public function hookLeftColumn($param) {
       $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'leftColumn');
        if(count($staticBlocks)<1) return null;
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
    
     public function hookRightColumn($param) { 
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'rightColumn');
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
    
    public function hookDisplayFooter($param) { 
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'displayFooter');
        if(count($staticBlocks)<1) return null;
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
    
    public function hookDisplayHome($param) {
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'displayHome');
        if(count($staticBlocks)<1) return null;
        //if(is_array($staticBlocks))
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
    
    public function hookBlockPosition1($param) {
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'blockPosition1');
        if(count($staticBlocks)<1) return null;
        //if(is_array($staticBlocks))
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
	
	public function hookdisplayBlockPosition1($param) {
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'displayBlockPosition1');
        if(count($staticBlocks)<1) return null;
        //if(is_array($staticBlocks))
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
	
	public function hookdisplayBlockPosition2($param) {
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'displayBlockPosition2');
        if(count($staticBlocks)<1) return null;
        //if(is_array($staticBlocks))
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
	
	public function hookdisplayBlockPosition3($param) {
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'displayBlockPosition3');
        if(count($staticBlocks)<1) return null;
        //if(is_array($staticBlocks))
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
	
	public function hookdisplayBlockPosition4($param) {
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'displayBlockPosition4');
        if(count($staticBlocks)<1) return null;
        //if(is_array($staticBlocks))
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
    
    public function hookBlockPosition2($param) {
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'blockPosition2');
        if(count($staticBlocks)<1) return null;
        //if(is_array($staticBlocks))
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
    
    public function hookBlockPosition3($param) {
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'blockPosition3');
        if(count($staticBlocks)<1) return null;
        //if(is_array($staticBlocks))
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
	
	public function hookproductExtraRight($param) {
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'productExtraRight');
        if(count($staticBlocks)<1) return null;
        //if(is_array($staticBlocks))
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
	public function hookBlockPosition4($param) {
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'blockPosition4');
        if(count($staticBlocks)<1) return null;
        //if(is_array($staticBlocks))
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
	public function hookBlockPosition5($param) {
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'blockPosition5');
        if(count($staticBlocks)<1) return null;
        //if(is_array($staticBlocks))
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
    public function hookBannerSequence($param) {
        $id_shop = (int)Context::getContext()->shop->id;
        $staticBlocks = $this->_staticModel->getStaticblockLists($id_shop,'bannerSequence');
        if(count($staticBlocks)<1) return null;
        //if(is_array($staticBlocks))
        $this->smarty->assign(array(
            'staticblocks' => $staticBlocks,
        ));
       return $this->display(__FILE__, 'block.tpl');
    }
    
     public function hookDisplayBackOfficeHeader($params) {
		if (method_exists($this->context->controller, 'addJquery'))
		 {        
		  $this->context->controller->addJquery();
		  $this->context->controller->addJS(($this->_path).'js/staticblock.js');
		 }
    }
    
    
    public function getModulById($id_module) {
        return Db::getInstance()->getRow('
            SELECT m.*
            FROM `' . _DB_PREFIX_ . 'module` m
            JOIN `' . _DB_PREFIX_ . 'module_shop` ms ON (m.`id_module` = ms.`id_module` AND ms.`id_shop` = ' . (int) ($this->context->shop->id) . ')
            WHERE m.`id_module` = ' . $id_module);
    }
	
	 public function getHookModuleById($id=null) {
		  $id = Tools::getValue('id_posstaticblock'); echo $id; die('aa');
        return Db::getInstance()->getRow('
            SELECT *
            FROM `' . _DB_PREFIX_ . 'pos_staticblock`
            WHERE `id_posstaticblock` = ' . $id);
    }


   public function getHooksByModuleId($id_module) {
		  $sql = 'SELECT * FROM '._DB_PREFIX_.'hook_module AS `ps` LEFT JOIN '._DB_PREFIX_.'hook AS `ph` ON `ps`.`id_hook` = `ph`.`id_hook`  WHERE `ps`.`id_module`='.$id_module;
		$hooks = array();
	     if($object = Db::getInstance()->ExecuteS($sql)){
			 if(count($object)>0) {
				 foreach($object as $module_hook) {
					if(isset($module_hook['name']))
						$hooks[] = $module_hook['name'];
				 }
			 }
			
		 }
		 return $hooks; 
   }
   
      public function getContent()
    {
		
				
		$tab = new Tab((int) Tab::getIdFromClassName('AdminCmsBlock'));
        $tab->delete();


        $tab = new Tab();
		$tab->active = 1;
        // Need a foreach for the language
		$tab->name = array();
		$tab->class_name = 'AdminCmsBlock';
		foreach (Language::getLanguages() as $language) {
				$tab->name[$language['id_lang']] = $this->l('Manage Staticblocks');
		}
        $tab->module = $this->name;
        $tab->add();
		
		
		$url  = 'index.php?controller=AdminCmsBlock';
		$url .= '&token='.Tools::getAdminTokenLite('AdminCmsBlock');
		Tools::redirectAdmin($url);
	}

    public static function getHookByArrName($arrName) {
        $result = Db::getInstance()->ExecuteS('
		SELECT `id_hook`, `name`
		FROM `' . _DB_PREFIX_ . 'hook` 
		WHERE `name` IN (\'' . implode("','", $arrName) . '\')');
        return $result;
    }
  //$hooks = $this->getHooksByModuleId(10);
    public function getListModuleInstalled() {
        $mod = new posstaticblocks();
        $modules = $mod->getModulesInstalled(0);
        $arrayModule = array();
        foreach($modules as $key => $module) {
            if($module['active']==1) {
                $arrayModule[0] = array('id_module'=>0, 'name'=>'Chose Module');
                $arrayModule[$key] = $module;
            }
        }
        if ($arrayModule)
            return $arrayModule;
        return array();
    }
    
    private function _installHookCustomer(){
		$hookspos = array(
				'blockPosition1',
				'blockPosition2',
				'blockPosition3',
				'blockPosition4',
				'blockPosition5',
				'productExtraRight',
				'displayNav',
				'bannerSequence'
			); 
		foreach( $hookspos as $hook ){
			if( Hook::getIdByName($hook) ){
				
			} else {
				$new_hook = new Hook();
				$new_hook->name = pSQL($hook);
				$new_hook->title = pSQL($hook);
				$new_hook->add();
				$id_hook = $new_hook->id;
			}
		}
		return true;
	}

}