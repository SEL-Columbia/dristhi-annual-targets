class AnmReportAnnualTargetSp < ActiveRecord::Base
  self.table_name = "report.annual_target"

  belongs_to :dim_service_provider, :foreign_key => 'service_provider'
  belongs_to :dim_indicator_sp, :foreign_key => 'indicator'

  validates_presence_of :dim_service_provider, :dim_indicator_sp, :target, :start_date, :end_date

  def self.import(anm_identifier, indicator, target, start_date, end_date)
    anm_report_annual_target_sp = fetch(anm_identifier, indicator, start_date, end_date)
    if(anm_report_annual_target_sp.nil?)
      anm_report_annual_target_sp = AnmReportAnnualTargetSp.new(:start_date => start_date, :end_date => end_date)
      anm_report_annual_target_sp.dim_service_provider = DimServiceProvider.where(:dim_anm_sp => DimAnmSp.where(:anmidentifier => anm_identifier)).first
      anm_report_annual_target_sp.dim_indicator_sp = DimIndicatorSp.where(:indicator => indicator).first
    end
    anm_report_annual_target_sp.target = target
    if(anm_report_annual_target_sp.valid?)
      anm_report_annual_target_sp.save!
    end
  end

  def self.fetch(anm_identifier, indicator, start_date, end_date)
    AnmReportAnnualTargetSp.where(
        :dim_service_provider => DimServiceProvider.where(:dim_anm_sp => DimAnmSp.where(:anmidentifier => anm_identifier)),
        :indicator => DimIndicatorSp.where(:indicator => indicator),
        :start_date => start_date,
        :end_date => end_date).first
  end
end