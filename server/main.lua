

RegisterNetEvent("PayRental")
AddEventHandler("PayRental", function(amount)
    local source = source
    exports.rFw:RemoveMoney(source, amount)
end)
