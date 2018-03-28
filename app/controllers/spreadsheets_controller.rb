class SpreadsheetsController < ApplicationController
  before_action :set_api, only: [:show]
  before_action :set_spreadsheet, only: [:show]
  

  def new
    @spreadsheet = Spreadsheet.new
  end

  def create
    @spreadsheet = Spreadsheet.new(spreadsheet_params)
    @spreadsheet.name =  @spreadsheet.name.split('/')[5]
    if @spreadsheet.save
      redirect_to spreadsheet_path(@spreadsheet)
    else
      #add restriction for unvailid url 
      render :new
    end
  end

  def show
    @responses = @service.get_spreadsheet(@spreadsheet.name)
    @tabs = @service.get_spreadsheet(@spreadsheet.name, fields: "sheets.properties").sheets
    @cols #讀tab名稱還有col名稱
    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
    else
      @tag = Tag.new
    end
  end

  private

  def set_api
    require 'google/apis/sheets_v4'
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.key = 'AIzaSyCw1eTY-S9Xuxqv4AZ_bfHDlxEJ3KsLuig'
    @service.authorization = nil
  end

  def set_spreadsheet
    @spreadsheet = Spreadsheet.find(params[:id])    
  end

  def spreadsheet_params
    params.require(:spreadsheet).permit(:name)
  end
end
