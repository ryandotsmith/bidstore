Factory.factories.each do |name, factory|
  Given /^an? #{name} exists with an? (.*) of "([^"]*)"$/ do |attr, value|
    @easy_factory_object = Factory(name, attr.gsub(' ', '_') => value)
  end
end
