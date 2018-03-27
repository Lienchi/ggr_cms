class SpreadsheetsController < ApplicationController
  def new
    @spreadsheet = Spreadsheet.new
  end

  def create
    @spreadsheet = Spreadsheet.new(spreadsheet_params)
    @spreadsheet.spreadsheet_id =  @spreadsheet.spreadsheet_id.split('/')[5]
    if @spreadsheet.save
      redirect_to spreadsheet_path(@spreadsheet)
    else
      #add restriction for unvailid url 
      render :new
    end
  end

  private

  def spreadsheet_params
    params.require(:spreadsheet).permit(:spreadsheet_id)
  end
end
