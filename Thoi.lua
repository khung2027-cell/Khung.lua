local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- CẤU HÌNH SIÊU ĐẨY (HÚT LÀ BAY MẤT TÍCH)
local PUSH_RADIUS = 20      -- Phạm vi quét (tăng lên một chút để đẩy từ xa)
local PUSH_FORCE = 350      -- Lực đẩy ngang (Cũ là 80, 350 là cực kỳ mạnh)
local UPWARD_FORCE = 150    -- Lực hất lên trời (Giúp mục tiêu bay bổng lên không trung)

RunService.Heartbeat:Connect(function()
	if not character or not hrp:IsDescendantOf(workspace) then return end
	
	for _, object in ipairs(workspace:GetChildren()) do
		local humanoid = object:FindFirstChildOfClass("Humanoid")
		local targetHrp = object:FindFirstChild("HumanoidRootPart")
		
		if humanoid and targetHrp and object ~= character then
			local distance = (hrp.Position - targetHrp.Position).Magnitude
			
			if distance <= PUSH_RADIUS then
				-- Tính hướng đẩy ngang
				local pushDirection = (targetHrp.Position - hrp.Position).Unit
				
				-- Chống tình trạng mục tiêu bị ghì xuống đất: Ép hủy trạng thái đứng yên của Humanoid
				humanoid:ChangeState(Enum.HumanoidStateType.FallingDown)
				
				-- Áp dụng siêu lực: Đẩy ra xa + Hất tung lên trời
				targetHrp.AssemblyLinearVelocity = (pushDirection * PUSH_FORCE) + Vector3.new(0, UPWARD_FORCE, 0)
			end
		end
	end
end)
