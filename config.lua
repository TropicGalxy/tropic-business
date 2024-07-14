return {
    Target = "ox", -- Set to either "qb" or "ox"

    businesses = {
        burgershot = {
            model = "u_m_y_burgerdrug_01", -- Set your ped model here
            coords = vector4(-1187.4, -877.69, 12.83, 34.2), -- Set your ped coordinates here
            job = "burgershot",
            price = 32000,
            blip = {
                name = 'Burgershot',
                sprite = 317,
                color = 29,
                scale = 0.6
            },
        },
    },
    business2 = {
            model = "u_m_y_burgerdrug_01", -- Set your ped model here
            coords = vector4(0, 0, 0, 0), -- Set your ped coordinates here
            job = "job",
            price = 0,
            blip = {
                name = 'My Business',
                sprite = 317,
                color = 29,
                scale = 0.6
            },
        },
    },

-- add more as needed

}
