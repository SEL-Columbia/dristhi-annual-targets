require 'rails_helper'

describe DimServiceProvider do

  it { should belong_to(:dim_anm_sp) }

  it { should belong_to(:dim_service_provider_type) }

  it { should validate_presence_of(:dim_anm_sp)}

  it { should validate_presence_of(:dim_service_provider_type)}

end