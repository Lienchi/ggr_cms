class TabsController < ApplicationController
  require 'google/apis/sheets_v4'
  before_action :set_api
 

  def create
    begin
      session["spreadsheet_id"] = params[:spreadsheet][:spreadsheet_url].split("/")[5]
      session["tabs"] = []
      session["js"] = {}
      @service.get_spreadsheet(session["spreadsheet_id"], fields: "sheets.properties").sheets.each_with_index do |tab, index|
        session["tabs"] << { index: index, name: tab.properties.title, dimension: "ROWS" } 
        session["js"][index] = {}
      end
    rescue
      redirect_to root_path
      flash[:alert] = "Please enter valid Google Spreadsheet url"
    end
  end
 
  def hide
    @tab_index = params[:tab_index]
  end


  def dimension
    @tab_index = params[:tab_index]
    @columns = []
    if session["tabs"][@tab_index.to_i]["dimension"] == "ROWS"
      session["tabs"][@tab_index.to_i]["dimension"]  = "COLUMNS"
      range = ("1".."1000").to_a
      @service.get_spreadsheet_values(session["spreadsheet_id"], session["tabs"][@tab_index.to_i]["name"], major_dimension: "COLUMNS").values[0].each_with_index do |column, index|  
        @columns << { index: index, name: column, category_id: 1, xml_name: nil, tab_id: @tab_index, range: range[index] }
      puts "COLUMNS"
      end
    else
      session["tabs"][@tab_index.to_i]["dimension"]  = "ROWS"
      range = ("A".."ZZ").to_a
      @service.get_spreadsheet_values(session["spreadsheet_id"], session["tabs"][@tab_index.to_i]["name"]).values[0].each_with_index do |column, index|
        @columns << { index: index, name: column, category_id: 1, xml_name: nil, tab_id: @tab_index, range: range[index] }
      puts "ROWS"
      end
    end  
  end
 
  private

  def set_api
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.key = Rails.application.config_for(:api)["api_key"]
    @service.authorization = nil
  end
 
end
