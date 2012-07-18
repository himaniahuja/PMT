# ==This controller creates, updates, deletes estimations
class EstimationsController < ApplicationController

  def edit
    #@estimation = Estimation.new
    @deliverable = Deliverable.find params[:deliverable_id]
    @estimation = @deliverable.estimation
    @complexities = Complexity.all
    @units = Unit.all
  end



  def update
    @deliverable = Deliverable.find params[:deliverable_id]
    @estimation = @deliverable.estimation

    respond_to do |format|
     if @estimation.update_attributes(params[:estimation])&&@estimation.update_attributes(:is_updated=>'t')
        format.html { redirect_to(@deliverable) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @estimation.errors, :status => :unprocessable_entity }
		end
	end
  end

  def dropdown_update
    @complexity=Complexity.find_by_id(params[:complexity_id])
    deliverable = Deliverable.find params[:deliverable_id]
    @estimation = deliverable.estimation
    respond_to do |format|
       format.js
     end
  end
end
