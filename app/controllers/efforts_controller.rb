class EffortsController < ApplicationController


  def new
    @effort = Effort.new
    @effort.deliverable_id = params[:deliverable_id]

    respond_to do |format|
      format.html
    end
  end

  def create
    if params[:effort]['interrupt_time'].empty?
      params[:effort]['interrupt_time'] = 0
    end

    @effort = Effort.new(params[:effort])
    @effort.owner = current_user

    respond_to do |format|
      if @effort.save
        format.html { redirect_to home_home_path }
        format.js
      else
        format.html { redirect_to(root_path, :notice => @effort.errors.full_messages.join(" , ")) }
      end

    end
  end
end
