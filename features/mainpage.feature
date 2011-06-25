Feature: Mainpage
	In Order to easily share links
	As A proud individual who owns a domain anme
	I Want to be able to share short links from my domain name

	Scenario: Load the main page
		When I go to the home page
		Then I should see "URL"
		And I should see "Slug"
		And I should see a button named "Make the Link!"

	Scenario: Submit a link
		Given I am on the home page
		When I fill in the following:
			| url  | http://www.apple.com |
		  | slug | aapl                 |
		And I press "Make the Link!"
		Then I should be on the results page for aapl
		And I should see "Your link is: "
