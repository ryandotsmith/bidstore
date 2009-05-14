Factory.factories.each do |name, factory|
  Given /^an? #{name} exists with an? (.*) of "([^"]*)"$/ do |attr, value|
    @object = Factory(name, attr.gsub(' ', '_') => value)
  end
end
