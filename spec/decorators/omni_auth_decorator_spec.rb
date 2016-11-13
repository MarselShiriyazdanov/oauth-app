require "rails_helper"

describe OmniAuthDecorator do
  let(:provider) { build :identity, provider: "google_oauth2" }
  let(:decorated) { described_class.new(provider) }

  describe "#provier_name" do
    it "returns provider name form locale" do
      expect(decorated.provider_name).to eq("Google")
    end
  end
end
