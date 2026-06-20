--[[
    Touch Fling Script với Khung Credit (GUI)
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

----------------------------------------------------------------
-- 1. TẠO KHUNG GUI CREDIT (KS)
----------------------------------------------------------------
-- Xóa GUI cũ nếu đã tồn tại để tránh trùng lặp
if CoreGui:FindFirstChild("FlingCreditGUI") then
    CoreGui.FlingCreditGUI:Destroy()
end

-- Tạo ScreenGui độc lập
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlingCreditGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Khung chính (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 80)
MainFrame.Position = UDim2.new(0.02, 0, 0.1, 0) -- Vị trí phía trên bên trái màn hình
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Màu nền tối sang trọng
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Có thể giữ chuột để kéo di chuyển trên màn hình
MainFrame.Parent = ScreenGui

-- Bo góc cho khung chính
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Viền màu (Stroke) cho đẹp mắt
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 170, 255) -- Viền xanh neon
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- Dòng chữ Tiêu đề
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0.4, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡ TOUCH FLING SCRIPT"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Parent = MainFrame

-- Dòng chữ Tác giả / Credit (Bạn có thể đổi chữ "KS" hoặc tên bạn tại đây)
local CreditLabel = Instance.new("TextLabel")
CreditLabel.Size = UDim2.new(1, 0, 0.5, 0)
CreditLabel.Position = UDim2.new(0, 0, 0.4, 0)
CreditLabel.BackgroundTransparency = 1
CreditLabel.Text = "Credit by: KS" -- Chỗ này để sửa tên Credit
CreditLabel.TextColor3 = Color3.fromRGB(0, 255, 150) -- Màu chữ xanh lá nổi bật
CreditLabel.TextSize = 16
CreditLabel.Font = Enum.Font.GothamBold
CreditLabel.Parent = MainFrame

----------------------------------------------------------------
-- 2. CODE LOGIC FLING (GIỮ NGUYÊN)
----------------------------------------------------------------
local HeartbeatConnection
HeartbeatConnection = RunService.Heartbeat:Connect(function()
    local Character = LocalPlayer.Character
    if not Character or not Character:Parent() then
        -- Nếu nhân vật chết, xóa GUI và tắt vòng lặp
        ScreenGui:Destroy()
        HeartbeatConnection:Disconnect()
        return
    end
    
    for _, part in pairs(Character:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            part.RotVelocity = Vector3.new(0, 50, 0)
        end
    end
end)
