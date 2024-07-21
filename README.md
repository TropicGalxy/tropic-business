# tropic-business


A simple way to buy businesses

# Dependencies:

- [ox target](https://github.com/overextended/ox_target) 

or 

- [qb target](https://github.com/qbcore-framework/qb-target) -- THIS IS NOT TESTED

# Installation 

choose your target in the fxmanifest

configurate to your liking (you can check client.lua for an extra config option)

drag and drop the script to your server files

restart the server

IF USING LICENSES:

qb:

-- In qb-core/shares/items.lua file

-- Tropic Business
business_license 	        = {name = 'business_license', 		        label = 'Business License', 		 	    weight = 1, 		type = 'item', 		image = 'business_license.png', 	    unique = false, 	useable = true, 	shouldClose = true,	   combinable = nil,                    description = 'Business License'},

-----

ox

-- In ox-inventory shared items file

['business_license'] = {  
    label = 'Business License',  
    weight = 1,  
    type = 'item',  
    image = 'business_license.png',   
    canRemove = true,  
}


# Features

- Blips for locations

- Business Name

- Business Price

- The Businesses Job

- The Businesses Grade

- Ped Model

- Sell Back Percentage

- Buy Businesses With License

# Links 

Preview: https://youtu.be/WGHvTcwtjpw

Support: https://dsc.gg/tropicgalxy

Join the server i own: https://dsc.gg/tropicalroleplay

# Most Recent Update

added an option to buy the business with a license
