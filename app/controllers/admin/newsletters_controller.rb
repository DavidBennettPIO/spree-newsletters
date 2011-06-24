class Admin::NewslettersController < Admin::ResourceController
  
  def add_module
    params['module']['position'] = 100
    NewsletterLine.create(params['module'])
    module_list
  end
  
  def remove_module
    NewsletterLine.delete(params['module'])
    module_list
  end
  
  def module_list
    @newsletter = Newsletter.find(params['newsletter_id'])
    render :partial => 'admin/newsletters/module_list', :layout => false
  end
  
  def sort
    puts params['module']
    NewsletterLine.where(:newsletter_id => params['newsletter_id']).all.each do |nl|
      nl.position = params['module'].index(nl.id.to_s)
      nl.save
    end
    
    render :nothing => true
  end
  
  respond_override :update => { :html => { :success => lambda { redirect_to collection_url } } }
  respond_override :create => { :html => { :success => lambda { redirect_to collection_url } } }
  respond_override :destroy => { :js => { :success => lambda { render_js_for_destroy } } }
end
