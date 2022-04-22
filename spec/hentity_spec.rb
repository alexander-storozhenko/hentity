# frozen_string_literal: true

RSpec.describe Hentity do
  it "has a version number" do
    expect(Hentity::VERSION).not_to be nil
  end

  it "does something useful" do
    class Model < Hentity::Entity

      array :a, require: true, types: [
        integer(require: true),
        string(require: true)
      ]
    end

    model = Model.new({a: [1]})
  end
end
