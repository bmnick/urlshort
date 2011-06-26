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
		And I should see a short link for the "aapl slug"

	Scenario: Links should go to their given link
		Given I have a short link from "aapl" to "http://www.apple.com"
		And I am on the results page for aapl
		When I follow "Your short link"
		Then I should be at http://www.apple.com

	Scenario: Ungenerated slugs should fail gracefully
		When I go to asdf slug
		Then I should see "Sorry, this link doesn't exist"
	
	Scenario: The user shouldn't have to provide a slug
		Given I am on the home page
		When I fill in the following:
			| url | http://www.bmnick.com |
		And I press "Make the Link!"
		Then I should see "Your link is: "
