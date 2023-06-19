require 'rails_helper'

RSpec.describe UpdateSkuJob, type: :job do

    let(:book_name) { 'eloquent ruby' }
        allow(Net::HTTP).to recieve(:start).and_return(true) 
    before do

    end

    it "calls SKU service with correct params" do
        allow(Net::HTTP).to recieve(:start).and_return(true) 
        expect_any_instance_of(Net::HTTP::POST).to recieve(:body=).with(
            { sku: '123', name: book_name }.to_json
        ) 
        described_class.perform_now('eloquent ruby')
    end
end