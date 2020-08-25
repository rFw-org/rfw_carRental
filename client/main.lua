local menuOpen = false
local blipvisible = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)		
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local PedinVehicle = IsPedSittingInAnyVehicle(PlayerPedId())
        local JoueurDansLaZone = false
        for k,v in pairs(Config.PosList.zone) do
		
			if(GetDistanceBetweenCoords(coords, v.pos, true) < 1.30) then
				JoueurDansLaZone = true
			end		
		    if JoueurDansLaZone and not menuOpen then
               OpenLocation(v)
               menuOpen = true
            end
        end		
		if not JoueurDansLaZone then
            Citizen.Wait(150)
            menuOpen = false
            JoueurDansLaZone = false
        end
        if PedinVehicle and JoueurDansLaZone then
            menuOpen = false
            JoueurDansLaZone = false
        end
	end
end)

RMenu.Add('location', 'main', RageUI.CreateMenu("Car Rental", "Car Rental", nil, nil, "commonmenu", "gradient_bgd"))

RMenu:Get('location', 'main').Closed = function()
    menuOpen = false
end

function OpenLocation(info)
    if menuOpen then
        menuOpen = false
    else
        menuOpen = true
        RageUI.Visible(RMenu:Get('location', 'main'), true)
        local money = exports.rFw:GetPlayerMoney()
        Citizen.CreateThread(function()
            while menuOpen do
                RageUI.IsVisible(RMenu:Get('location', 'main'), function()
                    for k,v in pairs(Config.ListVeh) do                     
                        RageUI.Item.Button(v.name, nil, {RightLabel = "~g~"..v.prix.."$"}, true, {
                            onSelected = function()
                                local spawn, heading = SelectRandomSpawn(info.out)
                                if spawn ~= false then
                                    if money >= v.prix then
                                        RequestModel(v.model)                               
                                        while not HasModelLoaded(v.model) do Wait(1) end
                                        local veh = CreateVehicle(v.model, spawn, heading, 1, 0)
                                        TriggerServerEvent('PayRental', v.prix)
                                        SetEntityAsMissionEntity(veh, 1, 1)
                                        TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
                                    else
                                        ShowNotification("Vous n'avez pas assez d'argent")
                                    end
                                else
                                    ShowNotification("La zone est encombrée")
                                end
                            end,
                        })
                    end 
            
                end, function()
                end)
                Wait(1)
            end
        end)

    end
end


function SelectRandomSpawn(zone)
    local count = 0
    for k,v in pairs(zone) do
        count = count + 1
        local r = zone[math.random(1, #zone)]
        if IsSpawnPointClear(r.pos, 2.0) then
            return r.pos, r.heading
        end
        if count >= #zone then
            break
        end
    end
    return false
end



Citizen.CreateThread(function()
    if Config.MarkerVisible then
        while true do
            local pPed = GetPlayerPed(-1)
            local pCoords = GetEntityCoords(pPed)
            local marker = false

            
            for k,v in pairs(Config.PosList.zone) do
                if #(pCoords - v.pos) < Config.MarkerDistance then
                    DrawMarker(Config.Marker, v.pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerScale.x,Config.MarkerScale.y,Config.MarkerScale.z, Config.MarkerColor.r,Config.MarkerColor.g,Config.MarkerColor.b, 100, true, true, 2, false, false, false, false)
                    marker = true
                end
            end

            if marker then
                Wait(1)
            else
                Wait(250)
            end
        end
    end
end)

Citizen.CreateThread(function()
    if Config.BlipVisible then
		for _, info in pairs(Config.PosList.zone) do
			info.blip = AddBlipForCoord(info.pos)
			SetBlipSprite(info.blip, Config.Blip_Sprite)
			SetBlipDisplay(info.blip, Config.Blip_Display)
			SetBlipScale(info.blip, Config.Blip_Scale)
			SetBlipColour(info.blip, Config.Blip_Color)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Blip_Name)
			EndTextCommandSetBlipName(info.blip)        
        end
    end
end)