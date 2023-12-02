require 'rubygems'
require 'watir-webdriver'
require 'watirgrid'
require "helpers/setup.rb"
require "helpers/helperMethods.rb"
require "methods/methods.rb"
# require "methods/apis.rb"
# require "methods/dashboardGrid.rb"
# require "methods/dashboardSummary.rb"
# require "methods/groups.rb"
# require "methods/headerFooter.rb"
# require "methods/monitorDefinition.rb"
# require "methods/monitorExportSettings.rb"
# require "methods/monitorResults.rb"
# require "methods/monitors.rb"


def mohamed() 
  xt_login()
  xt_goToMonitor()
  xt_monitors_dragMonitorToGroup()



  #xt_logout()
  #xt_TearDown()
end 

def ben() 
  xt_login()
  # xt_dashboard_showHiddenGroup()
  # xt_dashboard_viewMonitor()
  #-------------------------------
  #UTR TESTING!!!!!!!!!!!!!!
  #-------------------------------
  #xt_utr_1614()
  #xt_utr_1616()
  #xt_utr_1617()
  #xt_utr_1619() 
  #xt_utr_1633() 
  #--------------------------------
  #MONITOR TESTING!!!!!!!!!!!!
  #--------------------------------
   xt_goToMonitor()
  # xt_monitors_definition_monitorType()
  # xt_monitors_definition_visibility_private()
  # xt_monitors_definition_visibility_shared()
  # xt_monitors_definition_criticality_low() 
  # xt_monitors_definition_alertSetting_active()
  # xt_monitors_definition_alertSetting_alertOnMissing()
  # xt_monitors_definition_alertSetting_alertOnNew() 
  # xt_monitors_definition_node_addNameFilter()
  # xt_monitors_definition_node_add_cancel()
  xt_monitors_definition_removeAttribute_single()
  # xt_monitors_goToExportSettings()
  # xt_monitors_exportSettings_schedule_manualDate()
  # xt_monitors_exportSettings_schedule_todaysDate()
  # xt_monitors_exportSettings_schedule_date()
  # xt_monitors_exportSettings_schedule_time() 
  # xt_monitors_exportSettings_schedule_recurrenceNone() 
  # xt_monitors_exportSettings_schedule_recurrenceDaily()
  # xt_monitors_exportSettings_schedule_repeat_everyWeekDay() 
  # xt_monitors_exportSettings_schedule_repeat_every()
  # xt_monitors_exportSettings_schedule_recurrenceWeekly()
  # xt_monitors_exportSettings_schedule_recurrenceMonthly()
  # xt_monitors_exportSettings_schedule_recurrenceYearly()
  # xt_monitors_exportSettings_schedule_endDate_endAfter()
  # xt_monitors_exportSettings_schedule_endDate_endBy() 
  # xt_monitors_exportSettings_schedule_endDate_none()
  # xt_monitors_exportSettings_format_csv()  
  # xt_monitors_exportSettings_format_tsv()
  # xt_monitors_exportSettings_format_xls()
  # xt_monitors_exportSettings_format_pdf()
  # xt_monitors_exportSettings_format_rtf()
  # xt_monitors_exportSettings_format_addPath()
  # xt_monitors_exportSettings_format_removePath()
  # xt_monitors_exportSettings_format_addDocumentFormat()
  # xt_monitors_exportSettings_format_removeDocumentFormat()
  #--------------------------------------------
  #ALERT GRID DASHBOARD TESTING!!!!!!!!!!!!
  #-------------------------------------------------
  # xt_dashboard_viewAllAlerts()
  # xt_dashboard_viewAllAlerts_gridFooter_lastPage()
  # xt_dashboard_viewAllAlerts_gridFooter_firstPage()
  # xt_dashboard_viewAllAlerts_gridSortAlerts()
  # xt_dashboard_viewAllAlerts_gridSortCollections()
  # xt_dashboard_viewAllAlerts_gridSortMonitor()
  # xt_dashboard_viewAllAlerts_gridSortSubsystem()
  # xt_dashboard_viewAllAlerts_gridSortMonitorType()
  # xt_dashboard_viewAllAlerts_gridSortNode()
  # xt_dashboard_viewAllAlerts_gridSortEntity()
  # xt_dashboard_viewAllAlerts_gridSortAttribute()
  # xt_dashboard_viewAllAlerts_gridSortPrevious()
  # xt_dashboard_viewAllAlerts_gridSortCurrent()
  # xt_dashboard_viewAllAlerts_gridDetails_attributeAlertHistory_verifyAlertType()
  # xt_dashboard_viewAllAlerts_gridDetails_attributeAlertHistory_addComment()
  # xt_dashboard_viewAllAlerts_gridDetails_attributeAlertHistory_clear()
  # xt_dashboard_viewAllAlerts_gridDetails_attributeAlertHistory_clearAll()
  # xt_dashboard_viewAllAlerts_gridDetails_attributeAlertHistory_close()
  # xt_dashboard_viewAllAlerts_gridClear()
  # xt_dashboard_viewAllAlerts_gridClear_addComment()
  # xt_dashboard_viewAllAlerts_gridClear_cancel() 
  # xt_dashboard_viewAllAlerts_gridClear_confirmClear()
  # xt_dashboard_viewAllAlerts_gridMonitorCell_monitorPage()
  #---------------------------------------------------
  xt_logout()
  xt_TearDown()
end 

def smoke_ui() 
  xt_login()
  xt_goToMonitor()
  
  xt_logout()
  xt_TearDown() 
end  

def regression_ui() 
  xt_headerLogo()
  xt_failedLogin()
  xt_loginRememberMe()
  xt_login()
  xt_goToDashboard()  
  xt_dashboard_graph()
  xt_dashboard_totalActiveMonitors() 
  xt_dashboard_totalAlerts() 
  xt_dashboard_totalAlertsChart() 
  xt_dashboard_totalChangedAlerts() 
  xt_dashboard_totalNewAlerts() 
  xt_dashboard_totalMissingAlerts() 
  xt_dashboard_viewAllAlerts() 
  xt_dashboard_viewAllAlerts_statusUncleared() 
  xt_dashboard_viewAllAlerts_refresh()  
  xt_dashboard_viewAllAlerts_groupColumns() 
  xt_dashboard_viewAllAlerts_gridFooter_rowsTotal() 
  xt_dashboard_viewAllAlerts_gridFooter_rowsPerPage25() 
  xt_dashboard_viewAllAlerts_gridFooter_rowsPerPage50() 
  xt_dashboard_viewAllAlerts_gridFooter_rowsPerPage75() 
  xt_dashboard_viewAllAlerts_gridFooter_rowsPerPage100() 
  xt_dashboard_viewAllAlerts_gridFooter_25next() 
  xt_dashboard_viewAllAlerts_gridFooter_50next() 
  xt_dashboard_viewAllAlerts_gridFooter_75next() 
  xt_dashboard_viewAllAlerts_gridFooter_100next() 
  xt_dashboard_viewAllAlerts_gridFooter_25previous() 
  xt_dashboard_viewAllAlerts_gridFooter_50previous() 
  xt_dashboard_viewAllAlerts_gridFooter_75previous() 
  xt_dashboard_viewAllAlerts_gridFooter_100previous() 
  xt_dashboard_viewAllAlerts_gridFooter_lastPage()      
  xt_dashboard_viewAllAlerts_gridFooter_firstPage() 
  xt_dashboard_viewAllAlerts_gridFooter_exportsResults() 
  xt_dashboard_viewAllAlerts_gridSortAlerts() # Grid cells don't have options: comments and alert nums 
  xt_dashboard_viewAllAlerts_gridSortCollections() 
  xt_dashboard_viewAllAlerts_gridSortMonitor() 
  xt_dashboard_viewAllAlerts_gridSortSubsystem() 
  xt_dashboard_viewAllAlerts_gridSortMonitorType() 
  xt_dashboard_viewAllAlerts_gridSortNode() 
  xt_dashboard_viewAllAlerts_gridSortEntity() 
  xt_dashboard_viewAllAlerts_gridSortAttribute() 
  xt_dashboard_viewAllAlerts_gridSortPrevious() 
  xt_dashboard_viewAllAlerts_gridSortCurrent() 
  xt_dashboard_viewAllAlerts_gridMonitorCell_monitorPage() 
  xt_goToDashboard() 
  xt_dashboard_viewAllAlerts()
  xt_dashboard_viewAllAlerts_gridClear() 
  xt_dashboard_viewAllAlerts_gridClear_cancel()
  xt_dashboard_viewAllAlerts_gridClear()
  xt_dashboard_viewAllAlerts_gridClear_addComment 
  xt_dashboard_viewAllAlerts_gridClear_confirmClear() 
  xt_dashboard_viewAllAlerts_gridSortAlerts()  
  xt_dashboard_viewAllAlerts_attributeAlertHistory_verifyAlertType() 
  xt_dashboard_viewAllAlerts_gridDetails_attributeAlertHistory_clear() 
  xt_dashboard_viewAllAlerts_gridDetails_attributeAlertHistory_close()
  
  xt_dashboard_viewAllAlerts_attributeAlertHistory_verifyAlertType()
  xt_dashboard_viewAllAlerts_gridDetails_attributeAlertHistory_addComment() 
  xt_dashboard_viewAllAlerts_gridDetails_attributeAlertHistory_clearAll() 
  xt_dashboard_viewAllAlerts_gridDetails_attributeAlertHistory_close()
  
  xt_dashboard_hideAllAlerts() 
  xt_goToMonitor()
  xt_monitors_createGroup_cancel()  
  xt_monitors_group_create()  
  xt_monitors_group_createBadName()  
  xt_monitors_group_rename()  
  xt_monitors_renameExistingGroup()  
  xt_monitors_group_delete()  
  xt_monitors_newGroup_addNewMonitors()  
  xt_monitors_newGroup_addExistingMonitors()  
  xt_monitors_modal_discardChanges() 
  xt_monitors_createMonitor_cancel()
  xt_monitors_createMonitor_cancelX()
  xt_monitors_createMonitorBadName()
  xt_monitors_createMonitorNoType()
  xt_monitors_createMonitor_saveAs()
  xt_monitors_createMonitor_reset()
  xt_monitors_createMonitor_auditPool()  
  xt_monitors_createMonitor_auditService()  
  xt_monitors_createMonitor_device()  
  xt_monitors_createMonitor_deviceAcl()  
  xt_monitors_createMonitor_diskFile()  
  xt_monitors_createMonitor_diskFileAcl()  
  xt_monitors_createMonitor_diskFilePattern()  
  xt_monitors_createMonitor_diskFilePatternAcl()  
  xt_monitors_createMonitor_DPAcl()  
  xt_monitors_createMonitor_globals()  
  xt_monitors_createMonitor_group()  
  xt_monitors_createMonitor_groupMember()  
  xt_monitors_createMonitor_groupOwner()  
  xt_monitors_createMonitor_guardianFile()  
  xt_monitors_createMonitor_objectType()  
  xt_monitors_createMonitor_objectTypeAcl()  
  xt_monitors_createMonitor_owner()  
  xt_monitors_createMonitor_process()  
  xt_monitors_createMonitor_processAcl()  
  xt_monitors_createMonitor_remotePassword()  
  xt_monitors_createMonitor_securityGroup()  
  xt_monitors_createMonitor_seep()  
  xt_monitors_createMonitor_subDevice()  
  xt_monitors_createMonitor_subDeviceAcl()  
  xt_monitors_createMonitor_subProcess()  
  xt_monitors_createMonitor_subProcessAcl()  
  xt_monitors_createMonitor_subvol()  
  xt_monitors_createMonitor_subvolAcl()  
  xt_monitors_createMonitor_terminal()  
  xt_monitors_createMonitor_user()  
  xt_monitors_createMonitor_volume()  
  xt_monitors_createMonitor_volumeAcl()  
  xt_monitors_renameExistingMonitor()  
  xt_monitors_renameMonitor()  
  xt_monitors_monitorSearch()  
  xt_monitors_dragMonitorToGroup()  
  xt_monitors_goToExportSettings()  
  xt_monitors_exportSettings_schedule_todaysDate()  
  xt_monitors_exportSettings_schedule_date()   
  xt_logout()
  xt_TearDown()
end  

def smoke_api() 
  # Read Env
  # Read Excel - will call call_apis() inside
end  

def regression_api() 
  # Read Env
  # Read Excel - will call call_apis() inside
end 

def regression_all()
  regression_ui()
  regression_api()
end

def smoke_all()
  smoke_ui()
  smoke_api()
end