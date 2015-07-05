class AnmReportAnnualTarget < ActiveRecord::Base
  self.table_name = "anm_report.annual_target"

  belongs_to :dim_anm, :foreign_key => 'anmidentifier'
  belongs_to :dim_indicator, :foreign_key => 'indicator'

  validates_presence_of :dim_anm, :dim_indicator, :target, :start_date, :end_date

  def self.import(anm_identifier, indicator, target, start_date, end_date)
    anm_report_annual_target = fetch(anm_identifier, indicator, start_date, end_date)
    if(anm_report_annual_target.nil?)
      anm_report_annual_target = AnmReportAnnualTarget.new(:start_date => start_date, :end_date => end_date)
      anm_report_annual_target.dim_anm = DimAnm.where(:anmidentifier => anm_identifier).first
      anm_report_annual_target.dim_indicator = DimIndicator.where(:indicator => indicator).first
    end
    anm_report_annual_target.target = target
    anm_report_annual_target.valid? ? anm_report_annual_target.save! : false
  end

  def self.fetch(anm_identifier, indicator, start_date, end_date)
    AnmReportAnnualTarget.where(
        :dim_anm => DimAnm.where(:anmidentifier => anm_identifier),
        :dim_indicator => DimIndicator.where(:indicator => indicator),
        :start_date => start_date,
        :end_date => end_date).first
  end
end
