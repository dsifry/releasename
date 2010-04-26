class ReleasesController < ApplicationController

  filter_resource_access
  
  layout "releases"
  
  def new
    @release = Release.generate
    @release.save!
    respond_to do |format|
#      flash[:notice] = 'Release was successfully created.'
      format.html { redirect_to(@release) }
      format.xml  { render :xml => @release, :status => :created, :location => @release }
   end
  end

  def index
    @releases = Release.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @releases }
      format.json { render :json => @releases }
    end
  end

  # GET /words/1
  # GET /words/1.xml
  def show
    @release = Release.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @release }
      format.json { render :json => @release }
    end
  end

    # PUT /releases/1
  # PUT /releases/1.xml
  def update
    @release = Release.find(params[:id])

    respond_to do |format|
      if @release.update_attributes(params[:release])
        flash[:notice] = 'Release was successfully updated.'
        format.html { redirect_to(@release) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @release.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /releases/1
  # DELETE /releases/1.xml
  def destroy
    @release = Release.find(params[:id])
    @release.destroy

    respond_to do |format|
      format.html { redirect_to(releases_url) }
      format.xml  { head :ok }
    end
  end
end
