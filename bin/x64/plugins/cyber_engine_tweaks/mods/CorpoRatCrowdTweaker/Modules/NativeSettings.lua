CORPORATCROWDS = {}

local config = require("Modules/config")
local config = require("Modules/functions")

local nativeSettings = GetMod("nativeSettings")

local BoolList = {[1] = "Off", [2] = "On"}

nativeSettings.addTab("/CORPORATCROWDS", "CorpoRat Crowd Tweaker")
nativeSettings.addSubcategory("/CORPORATCROWDS/Crowd", "Crowd")
nativeSettings.addSubcategory("/CORPORATCROWDS/CrowdMovement", "Crowd Movement")
nativeSettings.addSubcategory("/CORPORATCROWDS/Crowds", "Crowds")
nativeSettings.addSubcategory("/CORPORATCROWDS/ChaseTarget", "AI/Vehicle/ChaseTarget")
nativeSettings.addSubcategory("/CORPORATCROWDS/Navigation", "Editor/Navigation")
nativeSettings.addSubcategory("/CORPORATCROWDS/Traffic", "Traffic")
nativeSettings.addSubcategory("/CORPORATCROWDS/VehicleAI", "Vehicle AI")
nativeSettings.addSubcategory("/CORPORATCROWDS/Vehicle", "Vehicle")
nativeSettings.addSubcategory("/CORPORATCROWDS/ObjectSelection", "Object Selection")
nativeSettings.addSubcategory("/CORPORATCROWDS/ChoiceLookAt", "Failsafe/ChoiceLookAt")
nativeSettings.addSubcategory("/CORPORATCROWDS/MovementPolicies", "Movement Policies")
nativeSettings.addSubcategory("/CORPORATCROWDS/Marble", "Marble")
nativeSettings.addSubcategory("/CORPORATCROWDS/AI", "AI")
nativeSettings.addSubcategory("/CORPORATCROWDS/GameSenses", "Game Senses")
nativeSettings.addSubcategory("/CORPORATCROWDS/Occlusion", "Occlusion")
nativeSettings.addSubcategory("/CORPORATCROWDS/ReactionSystem", "Reaction System")


function CORPORATCROWDS:new()

--[Marble]
     nativeSettings.addRangeInt("/CORPORATCROWDS/Marble", "Avoidance Marbles Anticipation", "NPCs look ahead further / consider more nearby agents when planning avoidance. Movements look smoother, more natural, with fewer bumping incidents — but costs more CPU. (Default: 5)", 1, 10, 1, curSettings.iAvoidanceMarblesAnticipation, defaultSettings.iAvoidanceMarblesAnticipation, function(state)
		curSettings.iAvoidanceMarblesAnticipation = state
		GameOptions.SetInt('Marble', 'AvoidanceMarblesAnticipation', state)
     end)

     nativeSettings.addRangeInt("/CORPORATCROWDS/Marble", "Light Spreading Marble Anticipation", "Crowd agents try to “anticipate” movement in groups (e.g., groups of pedestrians walk together, avoid collisions collectively, and don’t scatter unnaturally). (Default: 5)", 1, 10, 1, curSettings.iLightSpreadingMarbleAnticipation, defaultSettings.iLightSpreadingMarbleAnticipation, function(state)
		curSettings.iLightSpreadingMarbleAnticipation = state
		GameOptions.SetInt('Marble', 'LightSpreadingMarbleAnticipation', state)
     end)

    nativeSettings.addSwitch("/CORPORATCROWDS/Marble", "Enable Anticipation Grouping", "Crowd agents try to 'anticipate' movement in groups (e.g., groups of pedestrians walk together, avoid collisions collectively, and don’t scatter unnaturally). (Default: 'On')", curSettings.bEnableAnticipationGrouping, defaultSettings.bEnableAnticipationGrouping, function(state)
		curSettings.bEnableAnticipationGrouping = state
		GameOptions.SetBool('Marble', 'EnableAnticipationGrouping', state)
	 end)
    nativeSettings.addSwitch("/CORPORATCROWDS/Marble", "Enable Player Slot", "NPCs reserve a personal avoidance bubble around the player, keeping a consistent space when walking nearby. This makes crowds part around V more naturally. (Default: 'Off')*", curSettings.bEnablePlayerSlot, defaultSettings.bEnablePlayerSlot, function(state)
		curSettings.bEnablePlayerSlot = state
		GameOptions.SetBool('Marble', 'EnablePlayerSlot', state)
	 end)
    nativeSettings.addSwitch("/CORPORATCROWDS/Marble", "Zebra Spread", "NPCs spread out laterally, fanning across the crosswalk instead of funneling in a straight line. Looks more natural and realistic in city environments. (Default: 'Off')*", curSettings.bEnableZebraSpread, defaultSettings.bEnableZebraSpread, function(state)
		curSettings.bEnableZebraSpread = state
		GameOptions.SetBool('Marble', 'EnableZebraSpread', state)
	 end)
    nativeSettings.addSwitch("/CORPORATCROWDS/Marble", "Local Path Projection", "Each agent projects a short “lookahead” path segment to anticipate local obstacles and flow around them smoothly (like a short-range dynamic path). Movements look more fluid and predictive. (Default: 'Off')*", curSettings.bLocalPathProjection, defaultSettings.bLocalPathProjection, function(state)
		curSettings.bLocalPathProjection = state
		GameOptions.SetBool('Marble', 'LocalPathProjection', state)
	 end)


--[AI/Vehicle/ChaseTarget]
    nativeSettings.addRangeFloat("/CORPORATCROWDS/ChaseTarget", "Avoidance Multiplier", "Determines how strongly AI drivers try to avoid collisions with other vehicles, pedestrians, or obstacles during a chase. (Default: 3)", 1, 10, 0.1, "%.1f", curSettings.fAvoidanceMultiplier, defaultSettings.fAvoidanceMultiplier, function(state)
        curSettings.fAvoidanceMultiplier = state
		GameOptions.SetFloat('AI/Vehicle/ChaseTarget', 'AvoidanceMultiplier', state)
    end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/ChaseTarget", "Default Multiplier", "Fallback multiplier used when the AI encounters a surface or navigation type that isn’t explicitly handled by another setting. (Default: 3)", 1, 10, 0.1, "%.1f", curSettings.fDefaultMultiplier, defaultSettings.fDefaultMultiplier, function(state)
        curSettings.fDefaultMultiplier = state
		GameOptions.SetFloat('AI/Vehicle/ChaseTarget', 'DefaultMultiplier', state)
    end)

    nativeSettings.addSwitch("/CORPORATCROWDS/ChaseTarget", "Keep Distance Enabled", "When 'On' chaser vehicles won’t ram constantly; they’ll slow down/hold position once they’re 'close enough'. (Default: 'On')", curSettings.bKeepDistanceEnabled, defaultSettings.bKeepDistanceEnabled, function(state)
		curSettings.bKeepDistanceEnabled = state
		GameOptions.SetBool('AI/Vehicle/ChaseTarget', 'KeepDistanceEnabled', state)
	 end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/ChaseTarget", "Roads Multiplier", "Lower values AI becomes more willing to cut corners, drive off-road, or take non-standard paths. (Default: 1)", 0.1, 10, 0.1, "%.1f", curSettings.fRoadsMultiplier, defaultSettings.fRoadsMultiplier, function(state)
        curSettings.fRoadsMultiplier = state
		GameOptions.SetFloat('AI/Vehicle/ChaseTarget', 'RoadsMultiplier', state)
    end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/ChaseTarget", "Stairs Multiplier", "Higher value AI avoids stairs more strongly. (Default: 100)", 1, 100, 1, "%0.1f", curSettings.fStairsMultiplier, defaultSettings.fStairsMultiplier, function(state)
        curSettings.fStairsMultiplier = state
		GameOptions.SetFloat('AI/Vehicle/ChaseTarget', 'StairsMultiplier', state)
    end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/ChaseTarget", "Terrain Multiplier", "It’s part of the surface cost system that tells the AI what kinds of ground are 'safe' or 'worth it' to drive on when deciding how to reach its target. (Default: 4)", 0.1, 10, 0.1, "%.1f", curSettings.fTerrainMultiplier, defaultSettings.fTerrainMultiplier, function(state)
        curSettings.fTerrainMultiplier = state
		GameOptions.SetFloat('AI/Vehicle/ChaseTarget', 'TerrainMultiplier', state)
    end)

--[Crowd]
    nativeSettings.addSwitch("/CORPORATCROWDS/Crowd", "Enabled", "Crowds Enabled (Default: 'On')", curSettings.bEnabled, defaultSettings.bEnabled, function(state)
		curSettings.bEnabled = state
		GameOptions.SetBool('Crowd', 'Enabled', state)
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/Crowd", "Enable Pedestrians", "Enable Pedestrians (Default: 'On')", curSettings.bEnablePedestrians, defaultSettings.bEnablePedestrians, function(state)
		curSettings.bEnablePedestrians = state
		GameOptions.SetBool('Crowd', 'EnablePedestrians', state)
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/Crowd", "Enable Vehicles", "Enable Vehicles (Default: 'On')", curSettings.bEnableVehicles, defaultSettings.bEnableVehicles, function(state)
		curSettings.bEnableVehicles = state
		GameOptions.SetBool('Crowd', 'EnableVehicles', state)
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/Crowd", "Only Corpo Man", "Only Corpo Man (Default: 'Off')", curSettings.bOnlyCorpoMan, defaultSettings.bOnlyCorpoMan, function(state)
		curSettings.bOnlyCorpoMan = state
		GameOptions.SetBool('Crowd', 'OnlyCorpoMan', state)
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/Crowd", "Use Frustum", "If Frustum is 'On' NPC outside your field of view are not rendered. (Default: 'On')* ('Off' will reduce the number of NPC's that dissappear when you turn around)*", curSettings.bUseFrustum, defaultSettings.bUseFrustum, function(state)
		curSettings.bUseFrustum = state
		GameOptions.SetBool('Crowd', 'UseFrustum', state)
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/Crowd", "Z Cutoff Enabled", "'On' agents outside the cutoff height are ignored for collision, movement, or simulation. Helps optimize tall structures or multi-level areas (Default: 'On')", curSettings.bZCutoffEnabled, defaultSettings.bZCutoffEnabled, function(state)
		curSettings.bZCutoffEnabled = state
		GameOptions.SetBool('Crowd', 'ZCutoffEnabled', state)
	 end)

    nativeSettings.addRangeInt("/CORPORATCROWDS/Crowd", "Z Cutoff", "The value for Z Cutoff height where rendering or simulating NPC crowds is stopped (Default: 20)*60", 1, 120, 1, curSettings.iZCutoff, defaultSettings.iZCutoff, function(state)
		curSettings.iZCutoff = state
		GameOptions.SetInt('Crowd', 'ZCutoff', state)
     end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Crowd", "Appropriate Minimum Distance To Player", "NPCs will spawn farther away, avoiding obvious pop-ins, but may leave nearby areas looking emptier until you move (Default: 10)*40", 10, 120, 1, "%.0f", curSettings.fAppropriateMinDistToPlayer, defaultSettings.fAppropriateMinDistToPlayer, function(state)
        curSettings.fAppropriateMinDistToPlayer = state
		GameOptions.SetFloat('Crowd', 'AppropriateMinDistToPlayer', state)
    end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Crowd", "Appropriate Minimum Last Seen Time", "Keeps NPCs hanging around longer, reducing immersion-breaking vanishing but costing memory/CPU (Default: 10)*40", 10, 120, 1, "%.0f", curSettings.fAppropriateMinLastSeenTime, defaultSettings.fAppropriateMinLastSeenTime, function(state)
        curSettings.fAppropriateMinLastSeenTime = state
		GameOptions.SetFloat('Crowd', 'AppropriateMinLastSeenTime', state)
    end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Crowd", "Despawn Last Seen Minimum Time", "Minimum time that a crowd entity remains active after last being seen by the player. (Default: 20)*40", 10, 120, 1, "%.0f", curSettings.fDespawnLastSeenMinTime, defaultSettings.fDespawnLastSeenMinTime, function(state)
        curSettings.fDespawnLastSeenMinTime = state
		GameOptions.SetFloat('Crowd', 'DespawnLastSeenMinTime', state)
    end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Crowd", "Base Parked Car Probability", "It controls the base probability that the game will spawn parked cars in the world. (Default: 0.80)*0.9", 0.01, 1.0, 0.01, "%.2f", curSettings.fBaseParkedCarProbability, defaultSettings.fBaseParkedCarProbability, function(state)
        curSettings.fBaseParkedCarProbability = state
		GameOptions.SetFloat('Crowd', 'BaseParkedCarProbability', state)
    end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Crowd", "Minimum Streaming Velocity Normalized To Block Spawn", "If the player is moving faster than this threshold, the game tries to avoid spawning new crowds/vehicles directly in front of you to prevent obvious pop-in (Default: 10)", 10, 120, 1, "%.0f", curSettings.fMinStreamingVelocityNormalizedToBlockSpawn, defaultSettings.fMinStreamingVelocityNormalizedToBlockSpawn, function(state)
        curSettings.fMinStreamingVelocityNormalizedToBlockSpawn = state
		GameOptions.SetFloat('Crowd', 'MinStreamingVelocityNormalizedToBlockSpawn', state)
    end)

    nativeSettings.addRangeInt("/CORPORATCROWDS/Traffic", "Spawn Limit", "More NPCs can be active, making the city feel busier, but can heavily impact performance — especially in areas like Japantown or markets. (Default: 1)*18", 1, 30, 1, curSettings.iSpawnLimit, defaultSettings.iSpawnLimit, function(state)
		curSettings.iSpawnLimit = state
		GameOptions.SetInt('Crowd', 'SpawnLimit', state)
     end)

--[Editor/Navigation]
    nativeSettings.addRangeFloat("/CORPORATCROWDS/Navigation", "Traffic Distance Threshold", "Cars appear further away, reducing visible pop-in but at a performance cost (more vehicles active at once). (Default: 10)*40", 10, 100, 1, "%.0f", curSettings.fTrafficDistanceThreshold, defaultSettings.fTrafficDistanceThreshold, function(state)
        curSettings.fTrafficDistanceThreshold = state
		GameOptions.SetFloat('Editor/Navigation', 'TrafficDistanceThreshold', state)
    end)

--[Traffic]
    nativeSettings.addSwitch("/CORPORATCROWDS/Traffic", "Disable LOD", "No LOD switching. All traffic cars look fully detailed, even far away. (Default: 'On')", curSettings.bDisableLOD, defaultSettings.bDisableLOD, function(state)
		curSettings.bDisableLOD = state
		GameOptions.SetBool('Traffic', 'DisableLOD', state)
	 end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Traffic", "Death Limit", "Controls the number of vehicles/pedestrians to be killed/destroyed before the system starts auto-despawning or ignoring further 'death' events. (Default: 10)", 1, 20, 1, "%.0f", curSettings.fDeathLimit, defaultSettings.fDeathLimit, function(state)        
		curSettings.fDeathLimit = state
		GameOptions.SetFloat('Traffic', 'DeathLimit', state)
	end)

    nativeSettings.addSwitch("/CORPORATCROWDS/Traffic", "Uncrowd MultiLane Roads", "Uncrowd MultiLane Roads, less traffic when driving (Default: 'On')*", curSettings.bUncrowdMultiLaneRoads, defaultSettings.bUncrowdMultiLaneRoads, function(state)
		curSettings.bUncrowdMultiLaneRoads = state
		GameOptions.SetBool('Traffic', 'UncrowdMultiLaneRoads', state)
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/Traffic", "Uncrowd One Lane Roads", "Uncrowd One Lane Roads, less traffic when driving (Default: 'On')*", curSettings.bUncrowdOneLaneRoads, defaultSettings.bUncrowdOneLaneRoads, function(state)
		curSettings.bUncrowdOneLaneRoads = state
		GameOptions.SetBool('Traffic', 'UncrowdOneLaneRoads', state)
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/Traffic", "Stop Spawn", "This controls whether new traffic vehicles are spawned (Default: 'Off')", curSettings.bStopSpawn, defaultSettings.bStopSpawn, function(state)
		curSettings.bStopSpawn = state
		GameOptions.SetBool('Traffic', 'StopSpawn', state)
	 end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Traffic", "Left Lane Speed Increase", "This controls how much faster vehicles in the left lane drive compared to the base speed (Default: 0.1)*2.8", 0.1, 5.0, 0.1, "%.1f", curSettings.fleftLaneSpeedIncrease, defaultSettings.fleftLaneSpeedIncrease, function(state)
        curSettings.fleftLaneSpeedIncrease = state
		GameOptions.SetFloat('Traffic', 'leftLaneSpeedIncrease', state)
	end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Traffic", "Minimum Drive Speed", "This ensures that traffic vehicles never slow below a certain speed (Default: 5)", 1.0, 15.0, 1.0, "%.0f", curSettings.fMinDriveSpeed, defaultSettings.fMinDriveSpeed, function(state)       
		curSettings.fMinDriveSpeed = state
		GameOptions.SetFloat('Traffic', 'MinDriveSpeed', state)
	end)

    nativeSettings.addSwitch("/CORPORATCROWDS/Traffic", "Speed Splicing", "If 'On', vehicles instantly snap to target speeds without interpolation. (Default: 'Off')", curSettings.bSpeedSplicing, defaultSettings.bSpeedSplicing, function(state)
		curSettings.bSpeedSplicing = state
		GameOptions.SetBool('Traffic', 'SpeedSplicing', state)
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/Traffic", "Safety Measure", "Controls whether vehicles take additional precautions to avoid collisions, pedestrians, or unsafe maneuvers (Default: 'Off')*", curSettings.bSafetyMeasure, defaultSettings.bSafetyMeasure, function(state)
		curSettings.bSafetyMeasure = state
		GameOptions.SetBool('Traffic', 'SafetyMeasure', state)
	 end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Traffic", "Safety Measure Distance", "Sets how much space to keep before deciding to take action (Default: 1.0)", 0.1, 10.0, 0.1, "%.1f", curSettings.fSafetyMeasureDistance, defaultSettings.fSafetyMeasureDistance, function(state)
		curSettings.fSafetyMeasureDistance = state
		GameOptions.SetBool('Traffic', 'SafetyMeasureDistance', state)
	 end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Traffic", "Slot Lane Occupancy Area Pedestrian Length", "Pedestrians will 'reserve' more space ahead/behind them, leading to wider gaps. (Default: 2.5)", 0.1, 10.0, 0.1, "%.1f", curSettings.fSlotLaneOccupancyArea_Pedestrian, defaultSettings.fSlotLaneOccupancyArea_Pedestrian, function(state)       
		curSettings.fSlotLaneOccupancyArea_Pedestrian = state
		GameOptions.SetFloat('Traffic', 'SlotLaneOccupancyArea_Pedestrian', state)
	end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Traffic", "Slot Lane Occupancy Area Vehicle Length", "Vehicles will 'reserve' more space ahead/behind them, leading to wider gaps in traffic (more cautious spacing). (Default: 6)*1", 0.1, 10.0, 0.1, "%.1f", curSettings.fSlotLaneOccupancyArea_Vehicle_Length, defaultSettings.fSlotLaneOccupancyArea_Vehicle_Length, function(state)       
		curSettings.fSlotLaneOccupancyArea_Vehicle_Length = state
		GameOptions.SetFloat('Traffic', 'SlotLaneOccupancyArea_Vehicle_Length', state)
	end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Traffic", "Spot Detection Precision", "The sampling resolution for 'spot' checks, used for detecting collisions or potential hazards. (Default: 5)", 0.1, 10.0, 0.1, "%.1f", curSettings.fSpotDetectionPrecision, defaultSettings.fSpotDetectionPrecision, function(state)       
		curSettings.fSpotDetectionPrecision = state
		GameOptions.SetFloat('Traffic', 'SpotDetectionPrecision', state)
	end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Traffic", "Spot Detection Range", "Defines the maximum distance that a traffic vehicle’s 'sensor' or detection system looks. (Default: 3)", 0.1, 10.0, 0.1, "%.1f", curSettings.fSpotDetectionRange, defaultSettings.fSpotDetectionRange, function(state)       
		curSettings.fSpotDetectionRange = state
		GameOptions.SetFloat('Traffic', 'SpotDetectionRange', state)
	end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Traffic", "Player Prediction", "How much the AI tries to 'guess' where you’ll be in the near future. (Default: 30)", 1, 50.0, 1.0, "%.0f", curSettings.fPlayerPrediction, defaultSettings.fPlayerPrediction, function(state)       
		curSettings.fPlayerPrediction = state
		GameOptions.SetFloat('Traffic', 'PlayerPrediction', state)
	end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Traffic", "Green Wave Average Predicted Car Speed", "This setting defines the average vehicle speed (in meters per second) that the traffic system assumes when calculating the timing and spacing of green waves. (Default: 10)", 1, 60.0, 1.0, "%.0f", curSettings.fGreenWaveAveragePredictedCarSpeed, defaultSettings.fGreenWaveAveragePredictedCarSpeed, function(state)       
		curSettings.fGreenWaveAveragePredictedCarSpeed = state
		GameOptions.SetFloat('Traffic', 'GreenWaveAveragePredictedCarSpeed', state)
	end)
    
	nativeSettings.addRangeFloat("/CORPORATCROWDS/Traffic", "Green Wave Length", "This setting defines the distance or “wavelength” of the green wave in meters — basically, the spatial interval between green light phases along a coordinated corridor. (Default: 300)", 50, 600, 1.0, "%.0f", curSettings.fGreenWaveLength, defaultSettings.fGreenWaveLength, function(state)       
		curSettings.fGreenWaveLength = state
		GameOptions.SetFloat('Traffic', 'GreenWaveLength', state)
	end)
    
	nativeSettings.addRangeFloat("/CORPORATCROWDS/Traffic", "Min Time Before Green Wave", "his setting defines the minimum amount of time that must pass before a traffic light participates in a green wave after it has switched red. (Default: 7)", 1, 9.0, 0.1, "%.1f", curSettings.fMinTimeBeforeGreenWave, defaultSettings.fMinTimeBeforeGreenWave, function(state)       
		curSettings.fMinTimeBeforeGreenWave = state
		GameOptions.SetFloat('Traffic', 'MinTimeBeforeGreenWave', state)
	end)
    
	nativeSettings.addRangeFloat("/CORPORATCROWDS/Traffic", "Max Time Before Green Wave", "This parameter defines the maximum amount of time a traffic light will wait before it participates in a green wave, even if the synchronization conditions aren’t ideal yet. (Default: 10)", 10, 50.0, 0.1, "%.1f", curSettings.fMaxTimeBeforeGreenWave, defaultSettings.fMaxTimeBeforeGreenWave, function(state)       
		curSettings.fMaxTimeBeforeGreenWave = state
		GameOptions.SetFloat('Traffic', 'MaxTimeBeforeGreenWave', state)
	end)

--[CrowdMovement]
    nativeSettings.addRangeFloat("/CORPORATCROWDS/CrowdMovement", "Ahead Angle Max", "Defines the half-cone in front of an NPC that the game treats as “forward space” for obstacle detection. (Default: 45)*80", 45, 120, 1, "%.0f", curSettings.fAheadAngleMax, defaultSettings.fAheadAngleMax, function(state)
        curSettings.fAheadAngleMax = state
		GameOptions.SetFloat('CrowdMovement', 'AheadAngleMax', state)
	end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/CrowdMovement", "Ahead Angle Min", "It’s essentially the inner boundary of the forward vision cone, area where peds care about what is in front of them (Default: 30)*20", 20, 40, 1, "%.0f", curSettings.fAheadAngleMin, defaultSettings.fAheadAngleMin, function(state)
        curSettings.fAheadAngleMin = state
		GameOptions.SetFloat('CrowdMovement', 'AheadAngleMin', state)
	end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/CrowdMovement", "Ahead Distance Max", "Maximum distance ahead that each NPC considers when determining movement, path smoothing, and collision avoidance. (Default: 2)*10", 3, 10, 1, "%.0f", curSettings.fAheadDistanceMax, defaultSettings.fAheadDistanceMax, function(state)
        curSettings.fAheadDistanceMax = state
		GameOptions.SetFloat('CrowdMovement', 'AheadDistanceMax', state)
	end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/CrowdMovement", "Ahead Distance Min", "Minimum distance ahead that each NPC considers when determining movement, path smoothing, and collision avoidance. (Default: 1)", 1, 3, 1, "%.0f", curSettings.fAheadDistanceMin, defaultSettings.fAheadDistanceMin, function(state)
        curSettings.fAheadDistanceMin = state
		GameOptions.SetFloat('CrowdMovement', 'AheadDistanceMin', state)
	end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/CrowdMovement", "Distance To Stop Buffer", "This defines an extra safety margin around the stop point. Even after the NPC decides 'I should stop', this buffer prevents them from overshooting or bumping into things. (Default: 0.25)", 0.01, 1, 0.01, "%.2f", curSettings.fDistanceToStopBuffer, defaultSettings.fDistanceToStopBuffer, function(state)
        curSettings.fDistanceToStopBuffer = state
		GameOptions.SetFloat('CrowdMovement', 'DistanceToStopBuffer', state)
	end)

   nativeSettings.addSwitch("/CORPORATCROWDS/CrowdMovement", "Enable Direction Post Process", "Walking animations and turns look more natural (Default: 'Off')*", curSettings.bEnableDirectionPostProcess, defaultSettings.bEnableDirectionPostProcess, function(state)
		curSettings.bEnableDirectionPostProcess = state
		GameOptions.SetBool('CrowdMovement', 'EnableDirectionPostProcess', state)
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/CrowdMovement", "Enable Direction Smoothing", "Better avoidance behavior; NPCs are less likely to collide abruptly. (Default: 'On')", curSettings.bEnableDirectionSmoothing, defaultSettings.bEnableDirectionSmoothing, function(state)
		curSettings.bEnableDirectionSmoothing = state
		GameOptions.SetBool('CrowdMovement', 'EnableDirectionSmoothing', state)
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/CrowdMovement", "Fence Gap Repulsors", "Improves crowd navigation in tight urban areas. (Default: 'Off')*", curSettings.bFenceGapRepulsors, defaultSettings.bFenceGapRepulsors, function(state)
		curSettings.bFenceGapRepulsors = state
		GameOptions.SetBool('CrowdMovement', 'FenceGapRepulsors', state)
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/CrowdMovement", "Force Stop Colliders", "When 'Off' NPCs may slow down or adjust direction instead of stopping outright. (Default: 'Off')", curSettings.bForceStopColliders, defaultSettings.bForceStopColliders, function(state)
		curSettings.bForceStopColliders = state
		GameOptions.SetBool('CrowdMovement', 'ForceStopColliders', state)
	 end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/CrowdMovement", "Fear Spread Radius", "Panicked behavior spreads to more nearby NPCs, crowds react more dramatically to events (Default: 10)", 1, 20, 1, "%.0f", curSettings.fFearSpreadRadius, defaultSettings.fFearSpreadRadius, function(state)
        curSettings.fFearSpreadRadius = state
		GameOptions.SetFloat('CrowdMovement', 'FearSpreadRadius', state)
	end)

    nativeSettings.addSwitch("/CORPORATCROWDS/CrowdMovement", "Global Disable LOD", "When 'On' LOD is disabled for all crowd NPCs. NPCs look fully detailed at any distance. (Default: 'Off')*", curSettings.bGlobalDisableLOD, defaultSettings.bGlobalDisableLOD, function(state)
		curSettings.bGlobalDisableLOD = state
		GameOptions.SetBool('CrowdMovement', 'GlobalDisableLOD', state)
	 end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/CrowdMovement", "Lane Lights Recognition Distance", "This defines the distance at which NPC pedestrians detect and 'recognize' traffic lights that control crosswalks. (Default: 25)", 1, 35, 1, "%.0f", curSettings.fLaneLightsRecognitionDistance, defaultSettings.fLaneLightsRecognitionDistance, function(state)
        curSettings.fLaneLightsRecognitionDistance = state
		GameOptions.SetFloat('CrowdMovement', 'LaneLightsRecognitionDistance', state)
	end)

    nativeSettings.addSwitch("/CORPORATCROWDS/CrowdMovement", "Narrow Gap Repulsors", "NPCs avoid narrow gaps, preferring safer, wider paths. (Default: 'Off')", curSettings.bNarrowGapRepulsors, defaultSettings.bNarrowGapRepulsors, function(state)
		curSettings.bNarrowGapRepulsors = state
		GameOptions.SetBool('CrowdMovement', 'NarrowGapRepulsors', state)
	 end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/CrowdMovement", "Near End Distance", "At higher values NPCs will stop or switch to their next action earlier, without walking all the way to the exact endpoint (Default: 2)", 1, 10, 0.1, "%.1f", curSettings.fNearEndDistance, defaultSettings.fNearEndDistance, function(state)
        curSettings.fNearEndDistance = state
		GameOptions.SetFloat('CrowdMovement', 'NearEndDistance', state)
	end)

    nativeSettings.addSwitch("/CORPORATCROWDS/CrowdMovement", "No Gameplay No Update", "No Gameplay No Update (Default: 'Off')", curSettings.bNoGameplayNoUpdate, defaultSettings.bNoGameplayNoUpdate, function(state)
		curSettings.bNoGameplayNoUpdate = state
		GameOptions.SetBool('CrowdMovement', 'NoGameplayNoUpdate', state)
	 end)

    nativeSettings.addRangeInt("/CORPORATCROWDS/CrowdMovement", "Slope Samples", "More sampling points = smoother and more accurate slope detection (NPCs adapt better to ramps/stairs) but slightly more CPU cost. (Default: 10)*15", 5, 20, 1, curSettings.iSlopeSamples, defaultSettings.iSlopeSamples, function(state)
        curSettings.iSlopeSamples = state
		GameOptions.SetInt('CrowdMovement', 'SlopeSamples', state)
    end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/CrowdMovement", "Traffic Light Relevant Distance", "This controls how far away pedestrians or NPCs start reacting to traffic lights (Default: 4)", 1, 20, 1, "%.0f", curSettings.fTrafficLightRelevantDistance, defaultSettings.fTrafficLightRelevantDistance, function(state)
        curSettings.fTrafficLightRelevantDistance = state
		GameOptions.SetFloat('CrowdMovement', 'TrafficLightRelevantDistance', state)
	end)

--[Crowds]
     nativeSettings.addRangeFloat("/CORPORATCROWDS/Crowds", "Enter Workspot Delay", "Defines how long an NPC waits after reaching the spot before starting the assigned animation or activity (Default: 10)", 1, 20, 1, "%.0f", curSettings.fEnterWorkspotDelay, defaultSettings.fEnterWorkspotDelay, function(state)
        curSettings.fEnterWorkspotDelay = state
		GameOptions.SetFloat('Crowds', 'EnterWorkspotDelay', state)
	end)
 
   nativeSettings.addSwitch("/CORPORATCROWDS/Crowds", "Check On Lane Use Lookup", "NPCs use the lookup table to see if a lane is already occupied or 'safe' to enter. (Default: 'Off')*", curSettings.bCheckOnLaneUseLookup, defaultSettings.bCheckOnLaneUseLookup, function(state)
		curSettings.bCheckOnLaneUseLookup = state
		GameOptions.SetBool('Crowds', 'CheckOnLaneUseLookup', state)
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/Crowds", "Enable Items", "Enable Items (Default: 'On')", curSettings.bEnableItems, defaultSettings.bEnableItems, function(state)
		curSettings.bEnableItems = state
		GameOptions.SetBool('Crowds', 'EnableItems', state)
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/Crowds", "Marble Paths History", "Determines whether the system records the past positions and movement decisions of NPCs (Default: 'Off')*", curSettings.bMarblePathsHistoryEnabled, defaultSettings.bMarblePathsHistoryEnabled, function(state)
		curSettings.bMarblePathsHistoryEnabled = state
		GameOptions.SetBool('Crowds', 'MarblePathsHistoryEnabled', state)
	 end)

     nativeSettings.addRangeFloat("/CORPORATCROWDS/Crowds", "Max Speed Driving On Pavement", "Essentially, it acts as a clamp or normalization cap for how much a vehicle’s speed influences crowd panic intensity. (Default: 40)", 10, 100, 1, "%.0f", curSettings.fMaxSpeedDrivingOnPavement, defaultSettings.fMaxSpeedDrivingOnPavement, function(state)
        curSettings.fMaxSpeedDrivingOnPavement = state
		GameOptions.SetFloat('Crowds', 'MaxSpeedDrivingOnPavement', state)
	end)

     nativeSettings.addRangeFloat("/CORPORATCROWDS/Crowds", "Exponent Driving On Pavement", "Higher exponent pedestrians react more dramatically (Default: 2.0)", 0.1, 5, 0.1, "%.1f", curSettings.fExponentDrivingOnPavement, defaultSettings.fExponentDrivingOnPavement, function(state)
        curSettings.fExponentDrivingOnPavement = state
		GameOptions.SetFloat('Crowds', 'ExponentDrivingOnPavement', state)
	end)

--[MovementPolicies]
    nativeSettings.addSwitch("/CORPORATCROWDS/MovementPolicies", "Move Away From Target On Influence Map", "When 'On' AI will try to avoid areas marked as dangerous or undesirable, can prevent crowding, improve evasive behavior, or simulate threat avoidance (Default: 'Off')*", curSettings.bMoveAwayFromTargetOnInfluenceMap, defaultSettings.bMoveAwayFromTargetOnInfluenceMap, function(state)
		curSettings.bMoveAwayFromTargetOnInfluenceMap = state
		GameOptions.SetBool('MovementPolicies', 'MoveAwayFromTargetOnInfluenceMap', state)
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/MovementPolicies", "Run From Threat On Influence Map", "'On' NPCs detect nearby threats and actively try to move away from them using the influence map. (Default: 'Off')*", curSettings.bRunFromThreatOnInfluenceMap, defaultSettings.bRunFromThreatOnInfluenceMap, function(state)
		curSettings.bRunFromThreatOnInfluenceMap = state
		GameOptions.SetBool('MovementPolicies', 'RunFromThreatOnInfluenceMap', state)
	 end)


--[VehicleAI]
    nativeSettings.addRangeFloat("/CORPORATCROWDS/VehicleAI", "Perception Collision Propagation Area", "Defines the radius around a vehicle in which collision events or impacts influence AI decisions (Default: 2.0)", 1, 5, 0.01, "%.2f", curSettings.fPerceptionCollisionPropagationArea, defaultSettings.fPerceptionCollisionPropagationArea, function(state)
        curSettings.fPerceptionCollisionPropagationArea = state
		GameOptions.SetFloat('VehicleAI', 'PerceptionCollisionPropagationArea', state)
	end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/VehicleAI", "Perception Target Propagation Area", "Specifies the radius around the vehicle in which the AI considers other targets when planning maneuvers (Default: 1.5)", 1, 5, 0.01, "%.2f", curSettings.fPerceptionTargetPropagationArea, defaultSettings.fPerceptionTargetPropagationArea, function(state)
        curSettings.fPerceptionTargetPropagationArea = state
		GameOptions.SetFloat('VehicleAI', 'PerceptionTargetPropagationArea', state)
	end)


--[Vehicle]
	 nativeSettings.addSelectorString("/CORPORATCROWDS/Vehicle", "Pop Tire", "This controls whether (and sometimes how) a vehicle’s tires can burst/pop when damaged by gunfire, collisions, or scripted events. (Default: Off)*", BoolList, curSettings.iBoolList_Index, defaultSettings.iBoolList_Index, function(state)
		curSettings.iPopTire = ((curSettings.iBoolList_Index) - 1)
		curSettings.iBoolList_Index = state
		GameOptions.SetInt('Vehicle', 'PopTire', ((curSettings.iBoolList_Index) - 1))
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/Vehicle", "Toggle Tire Shooting", "Tires can be targeted and destroyed by bullets, explosions, or melee attacks. (Default: 'Off')*", curSettings.bToggleTireShooting, defaultSettings.bToggleTireShooting, function(state)
		curSettings.bToggleTireShooting = state
		GameOptions.SetBool('Vehicle', 'ToggleTireShooting', state)
	 end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Vehicle", "Force Move To Max Linear Speed", "This parameter defines how aggressively a vehicle ramps up to its top linear speed (Default: 30)", 1, 150, 1, "%.0f", curSettings.fForceMoveToMaxLinearSpeed, defaultSettings.fForceMoveToMaxLinearSpeed, function(state)
        curSettings.fForceMoveToMaxLinearSpeed = state
		GameOptions.SetFloat('Vehicle', 'ForceMoveToMaxLinearSpeed', state)
	end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/Vehicle", "Force Move To Max Angular Speed", "This option defines how aggressively a vehicle can rotate toward its maximum angular speed (Default: 5)", 1, 25, 1, "%.0f", curSettings.fForceMoveToMaxAngularSpeed, defaultSettings.fForceMoveToMaxAngularSpeed, function(state)
        curSettings.fForceMoveToMaxAngularSpeed = state
		GameOptions.SetFloat('Vehicle', 'ForceMoveToMaxAngularSpeed', state)
	end)

    nativeSettings.addSwitch("/CORPORATCROWDS/Vehicle", "Physics Continuous Collision Detection", "Better accuracy in high-speed collisions, cars less likely to clip through objects (Default: 'Off')*", curSettings.bphysicsCCD, defaultSettings.bphysicsCCD, function(state)
		curSettings.bphysicsCCD = state
		GameOptions.SetBool('Vehicle', 'physicsCCD', state)
	 end)

--[ObjectSelection]
    nativeSettings.addRangeInt("/CORPORATCROWDS/ObjectSelection", "Max Find Paths Limit", "This option throttles how many object pathfinding requests can be processed in a single frame (Default: 3)", 1, 20, 1, curSettings.iMaxFindPathsLimit, defaultSettings.iMaxFindPathsLimit, function(state)
        curSettings.iMaxFindPathsLimit = state
		GameOptions.SetInt('ObjectSelection', 'MaxFindPathsLimit', state)
    end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/ObjectSelection", "Max Find Paths Time Limit Ms", "Controls how long the vehicle AI pathfinder is allowed to spend searching for a route per update/frame before it gives up. (Default: 5)", 1, 20, 1, "%.0f", curSettings.fForceMoveToMaxAngularSpeed, defaultSettings.fForceMoveToMaxAngularSpeed, function(state)
        curSettings.fForceMoveToMaxAngularSpeed = state
		GameOptions.SetFloat('ObjectSelection', 'MaxFindPathsTimeLimitMs', state)
	end)

--[GameSenses]
    nativeSettings.addRangeInt("/CORPORATCROWDS/GameSenses", "Ray Tests Per Thread Limit", "AI can check more sight lines per frame → more accurate detection in dense scenes, but heavier CPU usage. (Default: 20)", 10, 80, 1, curSettings.iRayTestsPerThreadLimit, defaultSettings.iRayTestsPerThreadLimit, function(state)
        curSettings.iRayTestsPerThreadLimit = state
		GameOptions.SetInt('GameSenses', 'RayTestsPerThreadLimit', state)
    end)

    nativeSettings.addRangeInt("/CORPORATCROWDS/GameSenses", "Sensors To Update Limit", "More sensors update each frame → faster/more accurate perception, but higher CPU cost. (Default: 60,)", 30, 180, 1, curSettings.iSensorsToUpdateLimit, defaultSettings.iSensorsToUpdateLimit, function(state)
        curSettings.iSensorsToUpdateLimit = state
		GameOptions.SetInt('GameSenses', 'SensorsToUpdateLimit', state)
    end)


--[Occlusion]
    nativeSettings.addSwitch("/CORPORATCROWDS/Occlusion", "Force Full Test", "Every occlusion check runs completely, more accurate results (AI or rendering won’t miss hidden objects), but heavier on CPU/GPU. (Default: 'Off')*", curSettings.bForceFullTest, defaultSettings.bForceFullTest, function(state)
		curSettings.bForceFullTest = state
		GameOptions.SetBool('Occlusion', 'ForceFullTest', state)
	 end)

    nativeSettings.addRangeInt("/CORPORATCROWDS/Occlusion", "Test Phases Count", "More granular testing in a single frame, more accurate occlusion results, but higher CPU load. (Default: 3)", 1, 10, 1, curSettings.iTestPhasesCount, defaultSettings.iTestPhasesCount, function(state)
		curSettings.iTestPhasesCount = state
		GameOptions.SetInt('Occlusion', 'TestPhasesCount', state)
     end)

--[Failsafe/ChoiceLookAt]
    nativeSettings.addRangeFloat("/CORPORATCROWDS/ChoiceLookAt", "Activation Delay", "Longer delay before AI reacts; can make behaviors appear more natural or less twitchy. (Default: 0.50)", 0.10, 2, .10, "%.1f", curSettings.factivationDelay, defaultSettings.factivationDelay, function(state)
        curSettings.factivationDelay = state
		GameOptions.SetFloat('Failsafe/ChoiceLookAt', 'activationDelay', state)
	end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/ChoiceLookAt", "Activation Tolerance", "The AI can tolerate larger deviations from ideal conditions before triggering. The look-at may activate less frequently or more smoothly. (Default: 0.99)", 0.10, 1, 0.01, "%.2f", curSettings.factivationTolerance, defaultSettings.factivationTolerance, function(state)
        curSettings.factivationTolerance = state
		GameOptions.SetFloat('Failsafe/ChoiceLookAt', 'activationTolerance', state)
	end)

    nativeSettings.addRangeFloat("/CORPORATCROWDS/ChoiceLookAt", "Position Delta Reset", "This controls how much the target’s position can change before the AI resets its look-at calculation (Default: 0.50)", 0.10, 1.0, 0.1, "%.1f", curSettings.fpositionDeltaReset, defaultSettings.fpositionDeltaReset, function(state)
        curSettings.fpositionDeltaReset = state
		GameOptions.SetFloat('Failsafe/ChoiceLookAt', 'positionDeltaReset', state)
	end)

--[AI]
    nativeSettings.addSwitch("/CORPORATCROWDS/AI", "Code Tweak Actions Enabled", "This controls whether the AI applies “tweak actions” in its behavior logic — essentially small internal adjustments or experimental fixes in AI decision-making (Default: 'On')", curSettings.bCodeTweakActionsEnabled, defaultSettings.bCodeTweakActionsEnabled, function(state)
		curSettings.bCodeTweakActionsEnabled = state
		GameOptions.SetBool('AI', 'CodeTweakActionsEnabled', state)
	 end)

    nativeSettings.addSwitch("/CORPORATCROWDS/AI", "Enable Low FPS Detection", "The AI detects low FPS situations and reduces computation or simplifies logic to maintain performance (e.g., skipping some AI updates, pathfinding checks, or perception calculations). (Default: 'On')", curSettings.bEnableLowFPSDetection, defaultSettings.bEnableLowFPSDetection, function(state)
		curSettings.bEnableLowFPSDetection = state
		GameOptions.SetBool('AI', 'EnableLowFPSDetection', state)
	 end)

    nativeSettings.addRangeInt("/CORPORATCROWDS/AI", "LOD0 Bucket Size", "This controls the number of AI agents processed in the highest level of detail (LOD0) per update cycle (Default: 0)*16", 0, 16, 1, curSettings.iLOD0BucketSize, defaultSettings.iLOD0BucketSize, function(state)
        curSettings.iLOD0BucketSize = state
		GameOptions.SetInt('AI', 'LOD0BucketSize', state)
    end)

    nativeSettings.addRangeInt("/CORPORATCROWDS/AI", "LOD0 Tick Rate", "AI LOD0 agents are the highest-fidelity AI units, fully simulated with all behaviors and perception. This setting determines how often they are updated (Default: 1)", 1, 5, 1, curSettings.iLOD0TickRate, defaultSettings.iLOD0TickRate, function(state)
        curSettings.iLOD0TickRate = state
		GameOptions.SetInt('AI', 'LOD0TickRate', state)
    end)

    nativeSettings.addRangeInt("/CORPORATCROWDS/AI", "LOD1 Bucket Size", "AI LOD1 agents are medium-fidelity AI units — they receive simplified simulation compared to LOD0 (Default: 16)", 1, 16, 1, curSettings.iLOD1BucketSize, defaultSettings.iLOD1BucketSize, function(state)
        curSettings.iLOD1BucketSize = state
		GameOptions.SetInt('AI', 'LOD1BucketSize', state)
    end)

    nativeSettings.addRangeInt("/CORPORATCROWDS/AI", "LOD1 Tick Rate", "AI LOD1 agents are medium-fidelity AI units, so this controls how often their logic runs (Default: 4)", 1, 20, 1, curSettings.iLOD1TickRate, defaultSettings.iLOD1TickRate, function(state)
        curSettings.iLOD1TickRate = state
		GameOptions.SetInt('AI', 'LOD1TickRate', state)
    end)

    nativeSettings.addRangeInt("/CORPORATCROWDS/AI", "LOD2 Bucket Size", "AI LOD of long range NPC groups (Default: 16)", 1, 16, 1, curSettings.iLOD2BucketSize, defaultSettings.iLOD2BucketSize, function(state)
        curSettings.iLOD2BucketSize = state
		GameOptions.SetInt('AI', 'LOD2BucketSize', state)
    end)

    nativeSettings.addRangeInt("/CORPORATCROWDS/AI", "LOD2 Tick Rate", "AI LOD2 agents are low-fidelity AI units, which are simulated in a highly simplified way (Default: 8)", 1, 20, 1, curSettings.iLOD2TickRate, defaultSettings.iLOD2TickRate, function(state)
        curSettings.iLOD2TickRate = state
		GameOptions.SetInt('AI', 'LOD2TickRate', state)
    end)

    nativeSettings.addRangeInt("/CORPORATCROWDS/AI", "LOD3TickRate", "AI LOD3 agents are very low-detail AI units, typically for distant NPCs or large crowds (Default: 16)", 1, 20, 1, curSettings.iLOD3TickRate, defaultSettings.iLOD3TickRate, function(state)
        curSettings.iLOD3TickRate = state
		GameOptions.SetInt('AI', 'LOD3TickRate', state)
    end)

    nativeSettings.addSwitch("/CORPORATCROWDS/AI", "Variable Tick Rate Enabled", "This controls whether the AI system adapts its tick/update rate dynamically based on performance (Default: 'On')", curSettings.bVariableTickRateEnabled, defaultSettings.bVariableTickRateEnabled, function(state)
		curSettings.bVariableTickRateEnabled = state
		GameOptions.SetBool('AI', 'VariableTickRateEnabled', state)
	 end)

-- [ReactionSystem]

    nativeSettings.addSwitch("/CORPORATCROWDS/ReactionSystem", "Merging Fear Areas Enabled", "'On' NPCs’ fear trigger volumes will merge into bigger influence zones (instead of lots of overlapping tiny ones). If it’s 'Off', each fear area stays separate, which can make crowds react more locally and less “unified.” (Default: 'On')*", curSettings.bMergingFearAreasEnabled, defaultSettings.bMergingFearAreasEnabled, function(state)
		curSettings.bMergingFearAreasEnabled = state
		GameOptions.SetBool('ReactionSystem', 'MergingFearAreasEnabled', state)
	 end)

-------------------------------------------------------------------------------------------------
	
	local fromMods = false
	Observe("PauseMenuGameController", "OnMenuItemActivated", function (_, _, target)
		fromMods = target:GetData().label == "Mods"
	end) 
	Observe("gameuiMenuItemListGameController", "OnMenuItemActivated", function (_, _, target)
		fromMods = target:GetData().label == "Mods"
	end) 
	Observe("SettingsMainGameController", "RequestClose", function () 
		if fromMods then
			SaveFile("Data/config.json", curSettings)
			fromMods = false
		end
	end)
	
end

return CORPORATCROWDS:new()

