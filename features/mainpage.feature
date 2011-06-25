Feature: Mainpage
	In Order to easily share links
	As A proud individual who owns a domain anme
	I Want to be able to share short links from my domain name

	Scenario: Load the main page
		When I go to the home page
		Then I should see "URL"
		And I should see "Slug"
		And I should see a button named "Make the Link!"
