-- Mod by robber804
-- version 0.2.0 - Initial Release
-- Version 0.2.1 - Multiple Bug Fixes, Definitions added to settings
-- Version 0.2.2 - Added DespawnLastSeenMinTime,SafetyMeasure, DeathLimit, SlotLaneOccupancyArea_Vehicle_Length, NearEndDistance, 
--                 SlopeSamples, LaneLightsRecognitionDistance, DistanceToStopBuffer, popTire
-- Version 0.2.3 - Fixed SlopeSamples, fSlotLaneOccupancyArea_Pedestrian and EnterWorkSpotDelay
--               - Added SlotLaneOccupancyArea_Pedestrian
-- Version 0.2.4 - Added BaseParkedCarProbability, MinStreamingVelocityNormalizedToBlockSpawn, fixed typo's
-- Version 0.3.0 - ExponentDrivingOnPavement, RoadsMultiplier, StairsMultiplier, TerrainMultiplier,	SpotDetectionPrecision, SpotDetectionRange

local modVer='v0.3.0'
local modName='CorpoRat Crowd Tweaker'
local modAuthorName='robber804'

local CorpoCrowds = require "Modules/functions"


defaultSettings = {
	iBoolList_Index = 1,
--[Crowd]
	fAppropriateMinDistToPlayer = 10.000000,
	fAppropriateMinLastSeenTime = 10.000000,
	fBaseParkedCarProbability = 0.800000,
	fDespawnLastSeenMinTime = 20.000000,
	bEnablePedestrians = true,
	bEnableVehicles	= true,
	bEnabled = true, 
	fMinStreamingVelocityNormalizedToBlockSpawn = 10.000000,
	bOnlyCorpoMan = false,
	iSpawnLimit = 1,
	bUseFrustum = true,
	iZCutoff = 20,
	bZCutoffEnabled = true,

--[CrowdMovement]
	fAheadAngleMax = 45.000000,
	fAheadAngleMin = 30.000000,
	fAheadDistanceMax = 2.000000,
	fAheadDistanceMin = 1.000000,
-- AngularSpeedFactor = 5.000000
-- BlockingObstaclesDetectionDistance = 2.000000
-- BorderRepulsionSpeed = 7.000000
-- CAPlayerDistanceThresholdBack = 10.000000
-- CAPlayerDistanceThresholdFront = 30.000000
-- ClosestObstacleToStayInPlace = 2.000000
-- ComfortZoneRadiusFactor = 1.250000
-- DesiredForwardLookupDistance = 0.750000
-- DilationClamp = -1.000000
-- DilationLimit = -1.000000
-- DirectionSmoothingAngleTolerance = 45.000000
	fDistanceToStopBuffer = 0.250000,
	bEnableDirectionPostProcess = false,
	bEnableDirectionSmoothing = true,
-- EntryPathPositionFastExitAngle = 30.000000
-- EntryPathPositionSearchDistance = 10.000000
-- EntryPathPositionSearchStep = 1.000000
	fFearSpreadRadius = 10.000000,
	bFenceGapRepulsors = false,
-- FixedTimeStep = -1.000000
	bForceStopColliders = false,
-- FrontViewAngle = 45.000000
	bGlobalDisableLOD = false,
-- InjectedCollidersZTolerance = 2.500000
	fLaneLightsRecognitionDistance = 25.000000,
-- MarbleDirectionLookUp = 6
-- MarblePathDisplayMaxPoints = 5
-- MaxChancesToUseZebra = 4
-- MaxDirectionChangeAttempts = 4
-- MaxInterpAngle = 179.000000
-- MaxLanesCheckToJoinTrafficIfNotRelaxed = 10
-- MaxLanesCheckToJoinTrafficIfRelaxed = 4
-- MaxResumeMoveAttempts = 10
-- MinValidLanesCheckToJoinTraffic = 3
-- NPCObstaclesMass = 0.950000
-- NPCSeparationSpeed = 4.000000
	bNarrowGapRepulsors = false,
	fNearEndDistance = 2.000000,
	bNoGameplayNoUpdate = false,
-- ObstacleMarbleRadiusMultiplier = 1.200000
-- OppositePathToleranceInDeg = 20.000000
-- OverlapTolerance = 0.100000
-- PassingPoseStopAnimationTolerance = 0.100000
-- PathConvergenceSpeed = 10.000000
-- PathRefreshPlayerRadiusLimit = 10.000000
-- PlanLimitDistanceToReplan = 2.000000
-- PlayerObstaclesMass = 1.000000
-- PostProcessPositionCorrectionSpeed = 5.000000
-- RotationSpeedFactor = 5.000000
-- SeparationSpeedFactor = 2.000000
-- SeparationSpringTime = 5.000000
-- SharpAngle = 120.000000
	iSlopeSamples = 10,
-- SpeedCompensationFactor = 0.100000
	fTrafficLightRelevantDistance = 4.00000,
-- VehicleObstaclesMass = 1.050000

--[Crowds]
	bCheckOnLaneUseLookup = false,
	bEnableItems = true,
	bMarblePathsHistoryEnabled = false,
--BufferForAllowedDrivingOffRoadPercentOfCarWidth = 0.800000
--BufferForAllowedDrivingOnPavementPercentOfPavementSide = 0.500000
	fEnterWorkspotDelay = 10.000000,
	fMaxSpeedDrivingOnPavement = 40.000000,
	fExponentDrivingOnPavement = 2.000000,

--[AI/Vehicle/ChaseTarget]
	fAvoidanceMultiplier = 3.000000,
	fDefaultMultiplier = 3.000000,
	bKeepDistanceEnabled = true,
-- KeepDistanceQueueMargin = 20.000000
-- MaxKeepDistanceSpeedUp = 40.000000
	bNavmeshManeuversEnabled = true,
	bRammingEnabled = true,
	fRoadsMultiplier = 1.000000,
	fStairsMultiplier = 100.000000,
	fTerrainMultiplier = 4.000000,
	
--[Editor/Navigation]
	fTrafficDistanceThreshold = 10.0,

-- [ReactionSystem]
-- FearAreaRemovingDelay = 5.000000
-- FramesPerUpdateDeadBodies = 33
-- FramesPerUpdateDespawning = 14
-- FramesPerUpdateFearSourceState = 32
-- FramesPerUpdateRespawning = 95
	bMergingFearAreasEnabled = true,
-- MinDistanceToCommunityToRespawn = 30.000000

--[Marble]
	iAvoidanceMarblesAnticipation = 5,
-- ChainAngleSmooth = 10.000000
-- ChainAngleVariationTolerance = 120.000000
-- DirectionSmoothFactorMax = 1.000000
-- DirectionSmoothFactorMin = 0.500000
	bEnableAnticipationGrouping = true,
	bEnablePlayerSlot = false,
	bEnableZebraSpread = false,
	iLightSpreadingMarbleAnticipation = 5,
-- LocalPathMinimumPointDistance = 0.600000
	bLocalPathProjection = false,
-- MarbleAnticipationAngleTolerance = 70.000000
-- MarbleDebugLimit = 5
-- MarbleLookupRange = 6.000000
-- MarbleLookupZOffset = -1.000000
-- MarbleLookupZRange = 3.500000
-- MaximumFrontAngleToIgnoreObstacle = 45.000000
-- NPCMarbleRepulsionFactor = 1.200000
-- ObstacleLandingTimeTolerance = 2.000000
-- ObstacleStopOffset = 0.100000
-- SafePositionAngleDifferenceTolerance = 45.000000
-- StaticMarbleRepulsionFactor = 1.300000
-- ZebraEarlyStopMax = 1.250000
-- ZebraEarlyStopMin = 0.500000
-- ZebraSafePositionRadius = 0.500000

	
--[Traffic]
	bAvoidZebra2Zebra = true,
	bCurveLookahead = false,
	fDeathLimit = 10.000000,
	bDisableLOD = true,
-- DisplacementCap = 1.000000
	bDisposeOnOverlap = false,
	bDisposeOnSummon = true,
-- FrontAngle = 15.000000
-- MaxLocalPathLength = 100.000000
-- MaxPathLanes = 5
	fMinDriveSpeed = 5.000000,
-- PathLaneIntersectionDownTolerance = 1.000000
-- PathLaneIntersectionUpTolerance = 2.000000
	bSafetyMeasure = false,
	fSafetyMeasureDistance = 1.000000,
-- SideAngle = 10.000000
-- SkippingTimeTimeDilation = 3.000000
	fSlotLaneOccupancyArea_Pedestrian = 2.500000,
	fSlotLaneOccupancyArea_Vehicle_Length = 6.000000,
	bSpeedSplicing = false,
	fSpotDetectionPrecision = 5.000000,
	fSpotDetectionRange = 3.000000,
	bStopSpawn = false,
-- StraightTurnLimit = 15.000000
	bUncrowdMultiLaneRoads = true,
	bUncrowdOneLaneRoads = true,
	fleftLaneSpeedIncrease = 0.100000,
	fGreenWaveAveragePredictedCarSpeed = 10.000000,
	fGreenWaveLength = 200.000000,
	fMinTimeBeforeGreenWave = 7.000000,
	fMaxTimeBeforeGreenWave = 10.000000,
	fPlayerPrediction = 30.000000,

--[VehicleAI]
	bBlockAIDrivingPreset = false,
	bForceAIDrivingPreset = false,
	fPerceptionCollisionPropagationArea = 2.0,
	fPerceptionTargetPropagationArea = 1.5,
	
--[Vehicle]
	bAirControlBikePitchHelper = true,
	bAirControlCarRollHelper = true,
	--BikeHackTiltCalcValue = 50.000000,
	bBlockChangeGear = false,
	bDisableCollisionDamage = false,
	bEnableAirResistance = true,
	bEnableLateralTireSkidThinning = true,
	bEnableLowVelStoppingResistance = true,
	bEnableSmoothWheelContacts = true,
	fForceMoveToMaxAngularSpeed = 5.000000,
	fForceMoveToMaxLinearSpeed = 30.000000,
	fForceSimplifiedMovement = false,
	--LateralTireSkidThinningMultiplier = 2.000000
	--LateralTireSkidThinningVectorMaxLength = 17.500000
	--MaxSpeedFromPreviousActionSimplifiedMovement = 10.000000
	iPopTire = 0,
	bToggleTireShooting = false,
	bUseDifferential = true,
	--VelocitySmoothingTime = 0.300000,
	--WeightTransferMode = 1,
	bhelperCollisionObserverInViewOnly = false,
	bhelperCollisionObservers = true,
	bphysicsCCD = false,
	btrafficVsTrafficCollisions = false,
	bvehicleVsVehicleCollisions = true,

--[ObjectSelection]
	iMaxFindPathsLimit = 3,
	fMaxFindPathsTimeLimitMs = 3.000000,

--[Failsafe/ChoiceLookAt]
	factivationDelay = 0.500000,
	factivationTolerance = 0.99000,
	fpositionDeltaReset = 0.500000,

--[MovementPolicies]
	bMoveAwayFromTargetOnInfluenceMap = false,
	bRunFromThreatOnInfluenceMap = false,

--[Occlusion]
	-- BroadPhaseFraction = 16
	-- DepthBufferDimScale = 6
	-- FillphaseRangeFactor = 40.000000
	bForceFullTest = false,
	-- MaxDistance = 2000.000000
	-- MaxFarPlane = 8000.000000
	-- MinBufferHeight = 128
	-- MinBufferWidth = 256
	-- MinNearPlane = 0.200000
	-- MultiFrustumOcclusionMode = 1
	bMultiFrustumUseGlobalOcclusion = true,
	-- RastTilesJobGranularity = 1
	-- SortDist0 = 140.000000
	-- SortDist1 = 200.000000
	-- SortDist2 = 260.000000
	iTestPhasesCount = 3,

--[AI]
	bCodeTweakActionsEnabled = true,
	bEnableLowFPSDetection = true,
	iLOD0BucketSize = 0,
	iLOD0TickRate = 1,
	iLOD1BucketSize = 16,
	iLOD1TickRate = 4,
	iLOD2BucketSize = 16,
	iLOD2TickRate = 8,
	iLOD3TickRate = 16,
	--LODUpdatePeriod = 1.000000
	--LowFPSPerfThresholdMax = 59
	--LowFPSPerfThresholdMin = 48
	--LowFPSThresholdMax = 29
	--LowFPSThresholdMin = 24
	bVariableTickRateEnabled = true,

--[GameSenses]
	iRayTestsPerThreadLimit = 20,
	iSensorsToUpdateLimit = 60

}


function SaveFile(path, data)
    local file = io.open(path, "w")
    local jconfig = json.encode(data)
    file:write(jconfig)
    file:close()
end

function LoadFile(path)
    local file = io.open(path, "r")
	if file ~= nil then
		local config = json.decode(file:read("*a"))
		file:close()
        return config
	else
        return nil
	end
end

curSettings = LoadFile("Data/config.json")
if curSettings == nil then
    curSettings = defaultSettings
    SaveFile("Data/config.json", curSettings)
end


registerForEvent("onInit", function()
    require("Modules/NativeSettings")
		CorpoCrowds.InitSettings()
		print(modName..': '..modVer, 'initialized.')
end)
