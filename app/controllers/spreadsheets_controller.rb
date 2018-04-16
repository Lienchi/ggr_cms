class SpreadsheetsController < ApplicationController
  require 'google/apis/sheets_v4'
  before_action :set_api, only: [:create ]
  before_action :set_spreadsheet, only: [:show , :pdf]
  
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
    @col_arr = []
    @name_arr = []
    @category_arr = []
    session["js"].each do |key, value|
      value.each do |k,v|
        @name_arr << session["js"][key][k]["name"]
        @col_arr << session["js"][key][k]["range"]
        @category_arr << session["js"][key][k]["type"]
      end
    end
  end




 
  # def show
  #   @tabs = @spreadsheet.tabs

  #   #  @spreadsheed.name,有所有tags.col的陣列,有所有tags.name的陣列
  #   output_arr = []
  #   @col_arr = []
  #   @name_arr = []
  #   @category_arr = []
  #   @spreadsheet.tabs.each do |tab|
  #     tab.tags.each do |tag|
  #       unless tag.name.blank?
  #         output_arr << tag
  #       end  
  #     end 
  #   end
  #   output_arr.each do |x|
  #     @col_arr << x.tab.name + "!" + x.col_range+":"+ x.col_range
  #     @name_arr << x.name
  #     @category_arr << x.category_id
  #   end
  # end

  # def pdf
  #   @output_arr = []
  #   @spreadsheet.tabs.each do |tab|
  #     tab.tags.each do |tag|
  #       unless tag.name.blank?
  #         @output_arr << tag
  #       end  
  #     end 
  #   end
  #   render pdf: "./wkhtmltopdf test.html test.pdf" , encoding: 'utf8'
  # end


  private

  def set_api
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.key = Rails.application.config_for(:api)["api_key"]
    @service.authorization = nil
  end

  def set_spreadsheet
    @spreadsheet = Spreadsheet.find(params[:id])    
  end

  def spreadsheet_params
    params.require(:spreadsheet).permit(:name)
  end

  def build_by_google_spreadsheet(spreadsheet)
    unless spreadsheet.name.blank?
      url_arr = spreadsheet.name.split('/')
      if (url_arr.length > 5) && 
        (url_arr[0]+url_arr[1]+url_arr[2]+url_arr[3]+url_arr[4] == "https:docs.google.comspreadsheetsd") &&
        (url_arr[5].length == 44 )
        @spreadsheet.name =  url_arr[5]
        @spreadsheet.save
        tabs = @service.get_spreadsheet(spreadsheet.name, fields: "sheets.properties").sheets
        #save tabs 
        tabs.each do |tab|
          tab  = spreadsheet.tabs.build(name: tab.properties.title)
          tab.save
          #save tags
          range = ("A".."ZZ").to_a
          n = 0
          @service.get_spreadsheet_values(spreadsheet.name, tab.name).values[0].each do |column|
            col = tab.tags.build(tab_name: tab.name, col: column, spreadsheet_id: tab.spreadsheet.name, col_range: range[n], category_id: 1)
            col.save
            n += 1
          end
        end
        redirect_to spreadsheet_path(spreadsheet)
      else  
        flash[:alert] = "Please enter valid Google Spreadsheet"
        redirect_to new_spreadsheet_path
      end
    else
      flash[:alert] = "Spreadsheet can't be blank"
      redirect_to new_spreadsheet_path      
    end    
  end



end
