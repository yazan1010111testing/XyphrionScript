local cloneref = cloneref or function(ref: any)
    return ref
end

if isfolder('xyphrion') then
    delfolder('xyphrion')
end

cloneref(game:GetService('StarterGui')):SetCore('SendNotification', {
    Title = 'Xyphrion',
    Text = 'Successfully reinstalled Xyphrion, Please rejoin the game to take effect',
    Duration = 20
})