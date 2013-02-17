require 'spec_helper'

describe RubyCAS::Server::Core do
  describe "Testing database adapter" do
    it "raises an error" do
        expect { RubyCAS::Server::Core::Database.setup("spec/config/config.yml") }.to raise_error(NotImplementedError)
    end
  end

  describe "Initialization" do
    before do
        RubyCAS::Server::Core::Database.stub(:setup) { true }
        RubyCAS::Server::Core.setup("spec/config/config.yml")
    end

    it "Verify config file" do
      RubyCAS::Server::Core::Settings.maximum_session_lifetime.should be(172800)
    end

    it "Verify database settings" do
      RubyCAS::Server::Core::Settings.database.should be_kind_of(Hash)
      RubyCAS::Server::Core::Settings.database[:adapter].should eq("sqlite3")
    end

    it "Verify log settings" do
      RubyCAS::Server::Core::Settings.log.should be_kind_of(Hash)
      RubyCAS::Server::Core::Settings.log[:level].should eq("INFO")
    end

  end
end
