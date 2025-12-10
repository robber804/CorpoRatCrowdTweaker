local CorpoCrowds = {}

function CorpoCrowds.InitSettings()

--[Crowd]
	GameOptions.SetBool('Crowd', 'EnablePedestrians', curSettings.bEnablePedestrians)
	GameOptions.SetBool('Crowd', 'EnableVehicles', curSettings.bEnableVehicles)
	GameOptions.SetBool('Crowd', 'Enabled', curSettings.bEnabled)
	GameOptions.SetBool('Crowd', 'OnlyCorpoMan', curSettings.bOnlyCorpoMan)
	GameOptions.SetBool('Crowd', 'UseFrustum', curSettings.bUseFrustum)
	GameOptions.SetBool('Crowd', 'ZCutoffEnabled', curSettings.bZCutoffEnabled)
	GameOptions.SetInt('Crowd', 'SpawnLimit', curSettings.iSpawnLimit)
	GameOptions.SetInt('Crowd', 'ZCutoff', curSettings.iZCutoff)
	GameOptions.SetFloat('Crowd', 'AppropriateMinDistToPlayer', curSettings.fAppropriateMinDistToPlayer)
	GameOptions.SetFloat('Crowd', 'AppropriateMinLastSeenTime', curSettings.fAppropriateMinLastSeenTime)
	GameOptions.SetFloat('Crowd', 'DespawnLastSeenMinTime', curSettings.fDespawnLastSeenMinTime)
	GameOptions.SetFloat('Crowd', 'BaseParkedCarProbability', curSettings.fBaseParkedCarProbability)
	GameOptions.SetFloat('Crowd', 'MinStreamingVelocityNormalizedToBlockSpawn', curSettings.fMinStreamingVelocityNormalizedToBlockSpawn)

-- [ReactionSystem]
	GameOptions.SetBool('ReactionSystem', 'MergingFearAreasEnabled', curSettings.bMergingFearAreasEnabled)

--[CrowdMovement]
	GameOptions.SetFloat('CrowdMovement', 'AheadAngleMax', curSettings.fAheadAngleMax)
	GameOptions.SetFloat('CrowdMovement', 'AheadAngleMin', curSettings.fAheadAngleMin)
	GameOptions.SetFloat('CrowdMovement', 'AheadDistanceMax', curSettings.fAheadDistanceMax)
	GameOptions.SetFloat('CrowdMovement', 'AheadDistanceMin', curSettings.fAheadDistanceMin)
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
	GameOptions.SetFloat('CrowdMovement', 'DistanceToStopBuffer', curSettings.fDistanceToStopBuffer)
	GameOptions.SetBool('CrowdMovement', 'EnableDirectionPostProcess', curSettings.bEnableDirectionPostProcess)
	GameOptions.SetBool('CrowdMovement', 'EnableDirectionSmoothing', curSettings.bEnableDirectionSmoothing)
-- EntryPathPositionFastExitAngle = 30.000000
-- EntryPathPositionSearchDistance = 10.000000
-- EntryPathPositionSearchStep = 1.000000
	GameOptions.SetFloat('CrowdMovement', 'FearSpreadRadius', curSettings.fFearSpreadRadius)
	GameOptions.SetBool('CrowdMovement', 'FenceGapRepulsors', curSettings.bFenceGapRepulsors)
-- FixedTimeStep = -1.000000
	GameOptions.SetBool('CrowdMovement', 'ForceStopColliders', curSettings.bForceStopColliders)
-- FrontViewAngle = 45.000000
	GameOptions.SetBool('CrowdMovement', 'GlobalDisableLOD', curSettings.bGlobalDisableLOD)
-- InjectedCollidersZTolerance = 2.500000
	GameOptions.SetFloat('CrowdMovement', 'LaneLightsRecognitionDistance', curSettings.fLaneLightsRecognitionDistance)
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
	GameOptions.SetBool('CrowdMovement', 'NarrowGapRepulsors', curSettings.bNarrowGapRepulsors)
	GameOptions.SetFloat('CrowdMovement', 'NearEndDistance', curSettings.fNearEndDistance)
	GameOptions.SetBool('CrowdMovement', 'NoGameplayNoUpdate', curSettings.bNoGameplayNoUpdate)
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
	GameOptions.SetInt('CrowdMovement', 'SlopeSamples', curSettings.iSlopeSamples)
-- SpeedCompensationFactor = 0.100000
	GameOptions.SetFloat('CrowdMovement', 'TrafficLightRelevantDistance', curSettings.fTrafficLightRelevantDistance)
-- VehicleObstaclesMass = 1.050000

--[Crowds]
	GameOptions.SetBool('Crowds', 'CheckOnLaneUseLookup', curSettings.bCheckOnLaneUseLookup)
	GameOptions.SetBool('Crowds', 'EnableItems', curSettings.bEnableItems)
	GameOptions.SetBool('Crowds', 'MarblePathsHistoryEnabled', curSettings.bMarblePathsHistoryEnabled)
--BufferForAllowedDrivingOffRoadPercentOfCarWidth = 0.800000
--BufferForAllowedDrivingOnPavementPercentOfPavementSide = 0.500000
	GameOptions.SetFloat('Crowds', 'EnterWorkspotDelay', curSettings.fEnterWorkspotDelay)
	GameOptions.SetFloat('Crowds', 'ExponentDrivingOnPavement', curSettings.fExponentDrivingOnPavement)
	GameOptions.SetFloat('Crowds', 'MaxSpeedDrivingOnPavement', curSettings.fMaxSpeedDrivingOnPavement)

--[AI/Vehicle/ChaseTarget]
	GameOptions.SetFloat('AI/Vehicle/ChaseTarget', 'AvoidanceMultiplier', curSettings.fAvoidanceMultiplier)
	GameOptions.SetFloat('AI/Vehicle/ChaseTarget', 'DefaultMultiplier', curSettings.fDefaultMultiplier)
	GameOptions.SetBool('AI/Vehicle/ChaseTarget', 'KeepDistanceEnabled', curSettings.bKeepDistanceEnabled)
	GameOptions.SetFloat('AI/Vehicle/ChaseTarget', 'RoadsMultiplier', curSettings.fRoadsMultiplier)
	GameOptions.SetFloat('AI/Vehicle/ChaseTarget', 'StairsMultiplier', curSettings.fStairsMultiplier)
	GameOptions.SetFloat('AI/Vehicle/ChaseTarget', 'TerrainMultiplier', curSettings.fTerrainMultiplier)

--[Editor/Navigation]
	GameOptions.SetFloat('Editor/Navigation', 'TrafficDistanceThreshold', curSettings.fTrafficDistanceThreshold)

--[Traffic]
-- AvoidZebra2Zebra = true
-- CurveLookahead = false
-- DeathLimit = 10.000000
	GameOptions.SetFloat('Traffic', 'DeathLimit', curSettings.fDeathLimit)
	GameOptions.SetBool('Traffic', 'DisableLOD', curSettings.bDisableLOD)
-- DisplacementCap = 1.000000
-- DisposeOnOverlap = false
-- DisposeOnSummon = true
-- FrontAngle = 15.000000
-- MaxLocalPathLength = 100.000000
-- MaxPathLanes = 5
	GameOptions.SetFloat('Traffic', 'MinDriveSpeed', curSettings.fMinDriveSpeed)
-- PathLaneIntersectionDownTolerance = 1.000000
-- PathLaneIntersectionUpTolerance = 2.000000
	GameOptions.SetBool('Traffic', 'SafetyMeasure', curSettings.bSafetyMeasure)
-- SideAngle = 10.000000
-- SkippingTimeTimeDilation = 3.000000
	GameOptions.SetFloat('Traffic', 'SlotLaneOccupancyArea_Pedestrian', curSettings.fSlotLaneOccupancyArea_Pedestrian)
	GameOptions.SetFloat('Traffic', 'SlotLaneOccupancyArea_Vehicle_Length', curSettings.fSlotLaneOccupancyArea_Vehicle_Length)
	GameOptions.SetBool('Traffic', 'SpeedSplicing', curSettings.bSpeedSplicing)
	GameOptions.SetFloat('Traffic', 'SpotDetectionPrecision', curSettings.fSpotDetectionPrecision)
	GameOptions.SetFloat('Traffic', 'SpotDetectionRange', curSettings.fSpotDetectionRange)
	GameOptions.SetBool('Traffic', 'StopSpawn', curSettings.bStopSpawn)
-- StraightTurnLimit = 15.000000
-- TeleportationDistance = 340282346638528859811704183484516925440.000000
	GameOptions.SetBool('Traffic', 'UncrowdMultiLaneRoads', curSettings.bUncrowdMultiLaneRoads)
-- 	GameOptions.GetBool('Traffic', 'UncrowdMultiLaneRoads'
--	print('[Traffic] UncrowdMultiLaneRoads: ', GameOptions.GetBool("Traffic","UncrowdMultiLaneRoads"))	
	GameOptions.SetBool('Traffic', 'UncrowdOneLaneRoads', curSettings.bUncrowdOneLaneRoads)
	GameOptions.SetFloat('Traffic', 'leftLaneSpeedIncrease', curSettings.fleftLaneSpeedIncrease)
	GameOptions.SetFloat('Traffic', 'GreenWaveAveragePredictedCarSpeed', curSettings.fGreenWaveAveragePredictedCarSpeed)
	GameOptions.SetFloat('Traffic', 'GreenWaveLength', curSettings.fGreenWaveLength)
	GameOptions.SetFloat('Traffic', 'MinTimeBeforeGreenWave', curSettings.fMinTimeBeforeGreenWave)
	GameOptions.SetFloat('Traffic', 'MaxTimeBeforeGreenWave', curSettings.fMaxTimeBeforeGreenWave)
	GameOptions.SetFloat('Traffic', 'PlayerPrediction', curSettings.fPlayerPrediction)
	GameOptions.SetFloat('Traffic', 'SafetyMeasureDistance', curSettings.fSafetyMeasureDistance)

--[VehicleAI]
	GameOptions.SetFloat('VehicleAI', 'PerceptionCollisionPropagationArea', curSettings.fPerceptionCollisionPropagationArea)
	GameOptions.SetFloat('VehicleAI', 'PerceptionTargetPropagationArea', curSettings.fPerceptionTargetPropagationArea)

--[Vehicle]
	GameOptions.SetBool('Vehicle', 'AirControlBikePitchHelper', curSettings.bAirControlBikePitchHelper)
--	GameOptions.SetBool('Vehicle', 'BikeHackTiltCalcValue', curSettings.bBikeHackTiltCalcValue)
--	GameOptions.SetBool('Vehicle', 'BlockChangeGear', curSettings.bBlockChangeGear)
	GameOptions.SetBool('Vehicle', 'DisableCollisionDamage', curSettings.bDisableCollisionDamage)
--	GameOptions.SetBool('Vehicle', 'EnableAirResistance', curSettings.bEnableAirResistance)
--	GameOptions.SetBool('Vehicle', 'EnableLateralTireSkidThinning', curSettings.bEnableLateralTireSkidThinning)
	GameOptions.SetBool('Vehicle', 'EnableLowVelStoppingResistance', curSettings.bEnableLowVelStoppingResistance)
--	GameOptions.SetBool('Vehicle', 'EnableSmoothWheelContacts', curSettings.bEnableSmoothWheelContacts)
	GameOptions.SetFloat('Vehicle', 'ForceMoveToMaxAngularSpeed', curSettings.fForceMoveToMaxAngularSpeed)
	GameOptions.SetFloat('Vehicle', 'ForceMoveToMaxLinearSpeed', curSettings.fForceMoveToMaxLinearSpeed)
--	GameOptions.SetBool('Vehicle', 'ForceSimplifiedMovement', curSettings.bForceSimplifiedMovement)
-- LateralTireSkidThinningMultiplier = 2.000000
-- LateralTireSkidThinningVectorMaxLength = 17.500000
-- MaxSpeedFromPreviousActionSimplifiedMovement = 10.000000
	GameOptions.SetInt('Vehicle', 'PopTire', curSettings.iPopTire)
	GameOptions.SetBool('Vehicle', 'ToggleTireShooting', curSettings.bToggleTireShooting)
--	GameOptions.SetBool('Vehicle', 'UseDifferential', curSettings.bUseDifferential)
-- VelocitySmoothingTime = 0.300000
-- WeightTransferMode = 1
	GameOptions.SetBool('Vehicle', 'AirControlCarRollHelper', curSettings.bAirControlCarRollHelper)
--	GameOptions.SetBool('Vehicle', 'helperCollisionObserverInViewOnly', curSettings.bhelperCollisionObserverInViewOnly)
--	GameOptions.SetBool('Vehicle', 'helperCollisionObservers', curSettings.bhelperCollisionObservers)
	GameOptions.SetBool('Vehicle', 'physicsCCD', curSettings.bphysicsCCD)
--	GameOptions.SetBool('Vehicle', 'trafficVsTrafficCollisions', curSettings.btrafficVsTrafficCollisions)
--	GameOptions.SetBool('Vehicle', 'vehicleVsVehicleCollisions', curSettings.bvehicleVsVehicleCollisions)

--[ObjectSelection]
	GameOptions.SetInt('ObjectSelection', 'MaxFindPathsLimit', curSettings.iMaxFindPathsLimit)
	GameOptions.SetFloat('ObjectSelection', 'MaxFindPathsTimeLimitMs', curSettings.fMaxFindPathsTimeLimitMs)

--[Failsafe/ChoiceLookAt]
	GameOptions.SetFloat('Failsafe/ChoiceLookAt', 'activationDelay', curSettings.factivationDelay)
	GameOptions.SetFloat('Failsafe/ChoiceLookAt', 'activationTolerance', curSettings.factivationTolerance)
	GameOptions.SetFloat('Failsafe/ChoiceLookAt', 'positionDeltaReset', curSettings.fpositionDeltaReset)

--[MovementPolicies]
	GameOptions.SetBool('MovementPolicies', 'MoveAwayFromTargetOnInfluenceMap', curSettings.bMoveAwayFromTargetOnInfluenceMap)
	GameOptions.SetBool('MovementPolicies', 'RunFromThreatOnInfluenceMap', curSettings.bRunFromThreatOnInfluenceMap)

--[Occlusion]
	GameOptions.SetBool('Occlusion', 'ForceFullTest', curSettings.bForceFullTest)
	GameOptions.SetInt('Occlusion', 'TestPhasesCount', curSettings.iTestPhasesCount)

--[AI]
	GameOptions.SetBool('AI', 'EnableLowFPSDetection', curSettings.bEnableLowFPSDetection)
	GameOptions.SetInt('AI', 'LOD0BucketSize', curSettings.iLOD0BucketSize)
	GameOptions.SetInt('AI', 'LOD0TickRate', curSettings.iLOD0TickRate)
	GameOptions.SetInt('AI', 'LOD1BucketSize', curSettings.iLOD1BucketSize)
	GameOptions.SetInt('AI', 'LOD1TickRate', curSettings.iLOD1TickRate)
	GameOptions.SetInt('AI', 'LOD2BucketSize', curSettings.iLOD2BucketSize)
	GameOptions.SetInt('AI', 'LOD2TickRate', curSettings.iLOD2TickRate)
	GameOptions.SetInt('AI', 'LOD3TickRate', curSettings.iLOD3TickRate)

--[GameSenses]
	GameOptions.SetInt('GameSenses', 'RayTestsPerThreadLimit', curSettings.iRayTestsPerThreadLimit)
	GameOptions.SetInt('GameSenses', 'SensorsToUpdateLimit', curSettings.iSensorsToUpdateLimit)

--[Marble]
	GameOptions.SetInt('Marble', 'AvoidanceMarblesAnticipation', curSettings.iAvoidanceMarblesAnticipation)
-- ChainAngleSmooth = 10.000000
-- ChainAngleVariationTolerance = 120.000000
-- DirectionSmoothFactorMax = 1.000000
-- DirectionSmoothFactorMin = 0.500000
	GameOptions.SetBool('Marble', 'EnableAnticipationGrouping', curSettings.bEnableAnticipationGrouping)
	GameOptions.SetBool('Marble', 'EnablePlayerSlot', curSettings.bEnablePlayerSlot)
	GameOptions.SetBool('Marble', 'EnableZebraSpread', curSettings.bEnableZebraSpread)
	GameOptions.SetInt('Marble', 'LightSpreadingMarbleAnticipation', curSettings.iLightSpreadingMarbleAnticipation)
-- LocalPathMinimumPointDistance = 0.600000
	GameOptions.SetBool('Marble', 'LocalPathProjection', curSettings.bLocalPathProjection)
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

end

return CorpoCrowds