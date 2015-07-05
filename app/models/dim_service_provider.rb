class DimServiceProvider < ActiveRecord::Base
  self.table_name = "report.dim_service_provider"
  self.inheritance_column = nil

  belongs_to :dim_anm_sp, :foreign_key => 'service_provider'
  belongs_to :dim_service_provider_type, :foreign_key => 'type'

  validates_presence_of :dim_anm_sp, :dim_service_provider_type

end