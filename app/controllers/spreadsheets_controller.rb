class SpreadsheetsController < ApplicationController
  require 'google/apis/sheets_v4'
  before_action :set_api, only: [:create ]
  
  def new
    @spreadsheet = Spreadsheet.new
  end

  def create
    begin
      @spreadsheet = Spreadsheet.new(spreadsheet_params)
      build_by_google_spreadsheet(@spreadsheet)
    rescue
      flash[:alert] = "Please enter valid Google Spreadsheet"
      redirect_to new_spreadsheet_path
    end  
  end

  def js
    @spreadsheet = session["spreadsheet_id"]
    @col_range_arr = []
    @xml_name_arr = []
    @category_arr = []
    session["js"].each do |key, value|
      value.each do |k,v|
        @xml_name_arr << session["js"][key][k]["xml_name"]
        @col_range_arr << session["js"][key][k]["range"]
        @category_arr << session["js"][key][k]["type"]
      end
    end
  end

  def copy
    
  end

  def pdf
    @col_range_arr = []
    @xml_name_arr = []
    @category_arr = []
    @col_name_arr =[]
    session["js"].each do |key, value|
      value.each do |k,v|
        @xml_name_arr << session["js"][key][k]["xml_name"]
        @col_range_arr << session["js"][key][k]["range"]
        @category_arr << session["js"][key][k]["type"]
        @col_name_arr << session["js"][key][k]["name"]
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
