class AnmReportAnnualTarget < ActiveRecord::Base
  self.table_name = "anm_report.annual_target"

  belongs_to :dim_anm, :foreign_key => 'anmidentifier'
  belongs_to :dim_indicator, :foreign_key => 'indicator'

  validates_presence_of :dim_anm, :dim_indicator, :target, :start_date, :end_date

  def self.importFile(file)
    p file
    p file.path + "#####"
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]

      anm_identifier = row["ANM Identifier"]
      indicator = row["Indicator"]
      target = row["Target"]

      import(anm_identifier, indicator, target, Time.now.to_date, Time.now.to_date)
    end
  end

  def self.import(anm_identifier, indicator, target, start_date, end_date)
    anm_report_annual_target = fetch(anm_identifier, indicator, start_date, end_date)
    if(anm_report_annual_target.nil?)
      anm_report_annual_target = AnmReportAnnualTarget.new(:start_date => start_date, :end_date => end_date)
      anm_report_annual_target.dim_anm = DimAnm.where(:anmidentifier => anm_identifier).first
      anm_report_annual_target.dim_indicator = DimIndicator.where(:indicator => indicator).first
    end
    anm_report_annual_target.target = target
    if(anm_report_annual_target.valid?)
      anm_report_annual_target.save!
    end
  end

  def self.fetch(anm_identifier, indicator, start_date, end_date)
    AnmReportAnnualTarget.where(
        :dim_anm => DimAnm.where(:anmidentifier => anm_identifier),
        :indicator => DimIndicator.where(:indicator => indicator),
        :start_date => start_date,
        :end_date => end_date).first
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then
        Csv.new(file.path, nil, :ignore)
      when ".xls" then
        Excel.new(file.path, nil, :ignore)
      when ".xlsx" then
        Roo::Excelx.new(file.path)
      else
        raise "Unknown file type: #{file.original_filename}"
    end
  end

end
