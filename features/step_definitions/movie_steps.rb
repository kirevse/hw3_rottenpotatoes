# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  slctr = '//table[@id="movies"]/tbody/tr/td[1]'
  t1 = e1
  if t1 =~ /\d{2}-[a-zA-Z]{3}-\d{4}/
    t1 = Date.parse e1
    t2 = Date.parse e2
    array = page.all(:xpath, '//table[@id="movies"]/tbody/tr/td[3]').collect {|e| Date.parse e.text}
  else
    array = page.all(:xpath, '//table[@id="movies"]/tbody/tr/td[1]').collect {|e| e.text}
  end
  assert(array.index(t1) < array.index(t2))
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Then /I should see all of the movies/ do
  assert_equal(page.all(:xpath, '//table[@id="movies"]/tbody/tr').count, Movie.count)
end
