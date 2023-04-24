Config = {}

Config.Framework = 'ESX' --Framework used 'QBCore' or 'ESX'
Config.Command = 'jobad' --Command to trigger announce
Config.Duration = 7000   --Announce duration in ms
Config.Delay = 10000     --Time between announces to prevent spam

Config.Announces = {
    police = {
        minRank = 1,             --Min rank to announce
        background = 'test.png', --Background image name. Image 500px width 150px heigh
        color = 'white',         --Text color: names, rgb, #hex (any format accepted by CSS)
        shadow = 'black'         --Same as text
    },
    --Just copia and paste below to add new jobs
}
