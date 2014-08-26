module Spree
  module Admin
    class NewslettersController < ResourceController

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
        render :partial => 'spree/admin/newsletters/module_list', :layout => false
      end

      def sort
        puts params['module']
        NewsletterLine.where(:newsletter_id => params['newsletter_id']).all.each do |nl|
          nl.position = params['module'].index(nl.id.to_s)
          nl.save
        end

        render :nothing => true
      end

      def add_image
        image = NewsletterImage.new
        image.newsletter_image = file_upload_params
        image.newsletter_id = params[:newsletter_id]
        unless params[:image].nil?
          image.name = params[:image][:name] unless params[:image][:name].nil?
          image.href = params[:image][:href] unless params[:image][:href].nil?
        end
        image.save

        NewsletterLine.create({:newsletter_id => params[:newsletter_id], :position => 100, :module_name => 'image', :module_id => image.id, :module_value => params[:image][:name]})
        module_list

      end

      def new_copy

        @newsletter_copy = NewsletterCopy.new
        render 'new_copy', :layout => false

      end

      def create_copy

        copy = NewsletterCopy.new(params[:newsletter_copy])
        copy.newsletter_id = params[:newsletter_id]
        copy.save

        NewsletterLine.create({:newsletter_id => params[:newsletter_id], :position => 100, :module_name => 'copy', :module_value => copy.title, :module_id => copy.id})
        module_list

      end

      def edit_copy

        @newsletter_copy = NewsletterCopy.find(params[:newsletter_copy_id])
        render 'edit_copy', :layout => false

      end

      def update_copy

        NewsletterCopy.find(params[:newsletter_copy_id]).update_attributes(params[:newsletter_copy])
        module_list

      end

      def send_test

        @newsletter = Newsletter.find(params[:newsletter_id])

        Delayed::Job.enqueue NewsletterJob.new(nil, @newsletter.id)

        render :nothing => true

      end

      def send_email

        sids = params[:state_ids].map{|sid| sid.to_i if sid.to_i > 0}
        @newsletter = Newsletter.find(params[:newsletter_id])

        Delayed::Job.enqueue NewsletterJob.new(sids, @newsletter.id)

        redirect_to admin_newsletters_path

      end

      def file_upload_params
        h = Hash.new
        h = params[:Filedata]
        h.content_type = MIME::Types.type_for(h.original_filename).first.content_type
        h
      end

      respond_override :update => { :html => { :success => lambda { redirect_to collection_url } } }
      respond_override :create => { :html => { :success => lambda { redirect_to collection_url } } }
      respond_override :destroy => { :js => { :success => lambda { render_js_for_destroy } } }
    end

  end
end
