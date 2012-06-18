Deface::Override.new(:virtual_path => "layouts/admin",
                     :name => "admin_tab_newsletters",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab(:newsletters) %>",
                     :disabled => false)
                     
Deface::Override.new(:virtual_path => "layouts/admin",
                     :name => "admin_tab_newsletters",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab(:newsletters) %>",
                     :disabled => false)
