-- Mod by robber804
-- version 0.2.0 - Initial Release
-- Version 0.2.1 - Multiple Bug Fixes, Definitions added to settings
-- Version 0.2.2 - MaxNodesPerFrame & EditorThrottledMaxNodesPerFrame reduced to 700 max
-- Version 0.2.4 - Bug Fixes, updated descriptions, DistantGiFix, GarmentUseSmoothing, UseExperimentalVolFo, 
--                 EnableRTXDIDenoising, PermutationSamplingMode, EnableScalingCompensation, Capacity and GridSize
-- Version 0.3.0 - Changed how ReGIR settings are applied, UseSSRFallback, HistoryReset, UsePrevFrameBiasAllowance
--				 - Added NRD Nuker
-- Version 0.3.1 - Fixed typo in DistantGI, removed dead code, corrected suggested values, added IKTurnOffDistance,
--					TimeLimitSectorLoadPerFrame, TimeLimitSectorUnloadPerFrame, TimeLimitStreamedPerFrame RadiusNearSecondaryRefPointAddend
-- Version 0.3.2 - Fixed typo in RadiusNearSecondaryRefPointAddend
-- Version 0.4.0 - Added support for The Nullifier
--				 - fixed a lot of typos
-- Version 0.5.0 - added presets for pathtracing/raster/raytracing
--				 - added presets for denoiser
--				 - support for sosuine "Ray Traced Lighting Fixes"

local modVer='v0.5.0'
local modName='CorpoRat Graphics Tweaker'
local modAuthorName='robber804'
local Visuals = require "Modules/functions"
local GameUI = require('psibrex/GameUI')
local Cron = require('psibrex/Cron')
local state = nil
local player = nil
local runOnce = false

defaultSettings = {
	denoiser = 4,
	
	--[ResourceLoaderThrottler]
	iFloodMinNonLoadingThreads = 2,
	iStreamMaxLoadingThreads = 2,							
	iTrickleMaxLoadingThreads = 1,						
	
	--[World/Streaming/PersistencyCache]
	iMaxEntriesPerPage = 8,
	iPoolBudgetKB = 4096,

	--Editor/Denoising/NRD
	bEnableScalingCompensation = true,
	bUseReblurForDirectRadiance = false,
	bUseReblurForIndirectRadiance = false,

	--Streaming
	iEditorThrottledMaxNodesPerFrame = 500,
	iMaxNodesPerFrame = 300,
	fMinStreamingDistance = 1.0,
	fPrecacheDistance = 0.0,
	fTimeLimitSectorLoadPerFrame = 2.000000,
	fTimeLimitSectorUnloadPerFrame = 1.000000,
	fTimeLimitStreamedPerFrame = 6.000000,
	fRadiusNearSubtrahend = 200.0,
	fSpatialDebugRange = 500,
	fSpatialDebugDetailRange = 10,
	fRadiusNearSecondaryRefPointAddend = 200,
	
	--[Streaming/Culling]
	bStrict = false,
	
	--Streaming/Culling/AutoHideDistanceNear
	bStreamingCullingAutoHideDistanceNearEnabled = true,
	
	--Rendering
	bAllowRTXDIRejitter = false,
	bAllowRayTracedReferenceRejitter = false,
	fBloomLuminanceClampFactor = 0.07,
	bCheckerboardGI = true,
	-- DLSSDTransparentGuide = true
	bDistantGiFix = true,
	-- DistantShadowsDepthBias0 = 0.500000
	-- DistantShadowsDepthBias1 = 1.800000
	-- DistantShadowsDepthBias2 = 5.000000
	-- DistantShadowsDepthBias3 = 16.000000
	iDistantShadowsMaxBatchSize = 4000,
	iDistantShadowsMaxTrianglesPerBatch = 2147483647,
	-- DistantShadowsProxySortingMode = 2
	bGarmentUseSmoothing = true,
	-- HiResEntityCustomShadowmapSize = -1
	iMaxGbufferSplits = 8,
	iRainMapBatchMaxSize = 5000,
	iRainMapBatchMaxTrianglesPerBatch = 2147483647,
	-- RainMapProxySorting = true
	-- ReflectionProbe_FastBlend = false
	bUseExperimentalVolFog = true,
	-- UseSkinningLOD = true
	bForceAllShadows = false,
	fVolumetricFogVolume_DefaultAbsorption = 1.0,
	
	-- DLSS
	iDLSS_SampleNumber = 16,
	bEnableHalton = false,
	
	--Rendering/LUT
	iLUTMinRange_Index = 10,
	fLUTMaxRange = 100.0,
	fLUTMinRange = 0.001,
	iLUTSize = 48,

	--Editor/PathTracing
	bUseScreenSpaceData = false,
	
	--RayTracing
	bEnableRayTracing = true,
	bEnableShadowCascades = false,
	fCullingDistanceCharacter = 15.0,
	fCullingDistanceVehicle = 40.0,
	bEnableImportanceSampling = true,
	bEnableShadowOptimizations = true,
	bEnableGlobalShadow = true,
	bEnableLocalShadow = true,
	fTracingRadiusReflections = 2000,
	fTracingRadius = 200,
	bEnableAmbientOcclusion = true,
	bEnableTransparentReflection = true,
	bEnableDiffuseIllumination = true,
	bEnableReflection = true,
	bEnableGlobalIllumination = false,
	bForceShadowLODBiasUsage = true,
	bReflectionAdaptiveSampling = true,
	bDiffuseAdaptiveSampling = true,
	iScratchBufferSizeMB = 32,
	iGeometryUpdateBufferSizeMB = 64,
	iAccelerationStructureBuildNumMax = 64,
	bEnableNRD = true,
	iMaterialProxyUpdateNumMax = 65536,
	iMaterialProxyNumMax = 32,

	--[Developer/FeatureToggles]
	bCharacterRimEnhancement = true,
	bConstrastAdaptiveSharpening = true,
	bContactShadows = true,
	bScreenSpaceUnderwater = true,
	bVolumetricFog = true,
	bBloom = true,
	bScreenSpaceHeatHaze = true,
	bRTXDI = true,
	bScreenSpaceReflection = true,
	bScreenSpacePlanarReflection = true,
	bDistantGI = true,
	bCharacterSubsurfaceScattering = true,
	bCharacterSubsurfaceTranslucency = false,

	--[Editor/Audio/Features]
	bBreathingSystem = false,

	--[Rendering/Shadows]
	fCascadeRange0 = 12.000000,
	fCascadeRange1 = 30.000000,
	fCascadeRange2 = 75.000000,
	fCascadeRange3 = 150.000000,
	bCascadesHeuristicForceRefresh = false,
	fCascadesHeuristicMinMeshAutohideDistInCascade0 = 0.100000,
	fCascadesHeuristicMinMeshAutohideDistInCascade1 = 10.000000,
	fCascadesHeuristicMinMeshAutohideDistInCascade2 = 25.000000,
	fCascadesHeuristicMinMeshAutohideDistInCascade3 = 50.000000,
	fCascadesHeuristicMinMeshSizeInCascade0 = 0.100000,
	fCascadesHeuristicMinMeshSizeInCascade1 = 0.250000,
	fCascadesHeuristicMinMeshSizeInCascade2 = 0.750000,
	fCascadesHeuristicMinMeshSizeInCascade3 = 1.000000,
	fDistantHeuristicMinMeshAutohideDistInCascade0 = 25.000000,
	fDistantHeuristicMinMeshAutohideDistInCascade1 = 50.000000,
	fDistantHeuristicMinMeshAutohideDistInCascade2 = 150.000000,
	fDistantHeuristicMinMeshSizeInCascade0 = 1.000000,
	fDistantHeuristicMinMeshSizeInCascade1 = 1.500000,
	fDistantHeuristicMinMeshSizeInCascade2 = 3.000000,
	bDistantShadowsForceFoliageGeometry = false,
	
	--[Editor/Characters/Hair]
	bUseReferenceImplementation = false,
	fAlbedoMultiplier = 1.0,
	fRoughnessFactor = 1.0,
	fAdditionalAreaRoughness = 0.10,
	fSpecularRandom_Min = -0.2,
	fSpecularRandom_Max = 0.2,
	bUseGlobalContactShadowsOnHair = true,
	fContactShadowClamp = 0.35,
	
	--[Editor/Characters/Hair/Specular]
	fECHS_Wrap = 0.3,
	fECHS_Mask_Intensity = 1.0,
	
	--[Editor/Characters/Hair/MultiScatter]
	fECHM_Wrap = 0.3,
	fECHM_Mask_Intensity = 1.0,
	fECHM_DiffuseScatterFactor = 0.0,
	
	--[Editor/Characters/Hair/EnvProbe]
	fECHE_R = 0.3,
	fECHE_TT = 0.005,
	fECHE_TRT = 0.8,
	fECHE_MultiScatter = 0.47,
	fECHE_ScatterDepth = 1.3,
	
	--[Editor/Characters/Hair/LocalLight]
	fECHL_MultiScatter = 0.47,
	fECHL_ScatterDepth = 0.8,
	fECHL_R = 0.35,
	fECHL_TRT = 0.80,
	fECHL_TT = 0.005,

	--[Editor/Characters/Hair/GlobalLight]
	fECHG_R = 0.30,
	fECHG_TRT = 0.8,
	fECHG_ScatterDepth = 1.25,
	fECHG_MultiScatter = 0.47,
	fECHG_TT = 0.005,
	
	--[Editor/Characters/Hair/AlphaShifts]
	fECHA_TRT = -0.5,
	fECHA_R = -0.083,
	fECHA_TT = 1.0,
	
	--[Editor/Characters/Hair/HACKS]
	fECHH_HACK_Factor0 = 66.0,
	fECHH_HACK_Factor1 = 95.0,
	fECHH_HACK_Factor2 = 213.0,
	fECHH_HACK_Factor3 = 450.0,
	bECHH_AAAA_HACK_hairModifiedLocalLightIntensity = true,

	--[Editor/Characters/Hair/TRT_Params]
	fTRT_Params_EXP_SCALE = 1.0,
	fTRT_Params_EXP_BIAS = 1.5,
	
	--[Editor/Characters/Skin]
	bECS_AllowSkinAmbientMix = true,
	fECS_SkinAmbientMix_Factor = 1.0,
	fECS_SubsurfaceSpecularTintWeight = 0.3,
	fECS_SkinAmbientIntensity_Factor = 0.4,
	fECS_SubsurfaceSpecularTint_R = 0.21,
	fECS_SubsurfaceSpecularTint_G = 0.21,
	fECS_SubsurfaceSpecularTint_B = 0.29,
	
	--[Editor/Characters/Eyes]
	fECE_DiffuseBoost = 0.1,
	bUseAOOnEyes = false,
	
	--[Editor/SHARC]
	iSHARC_Bounces = 4,
	iSHARC_DownscaleFactor = 5,
	bSHARC_Enable = true,
	fSHARC_SceneScale = 50.000000,
	bUseRTXDIAtPrimary = false,
	bUseRTXDIWithAlbedo = true,
	fUsePrevFrameBiasAllowance = 0.25,
	iHistoryReset = 15,
	bUsePrevFrame = true,
	bClear = false,

	--Editor/RTXDI
	bEnableLocalLightImportanceSampling = false,
    bEnableSeparateDenoising = true,
	bEnableFallbackLight = true,
	fShadowFadeFraction = 0.1,
	fForcedShadowLightSourceRadius = 0.1,
	bEnableApproximateTargetPDF = false,
	bEnableGradients = false,
	bUseCustomDenoiser = false,
	bEnableRTXDIDenoising = true,
	bInitialCandidatesInTemporal = false,
	bEnableEnvironmentLights = false,
	iRTXDI_BiasCorrectionMode = 2,
	iRTXDI_PermutationSamplingMode = 2,
	fRTXDI_BoilingFilterStrength = 0.500000,
	iRTXDI_NumInitialSamples = 8,
	iRTXDI_NumEnvMapSamples = 8,
	iRTXDI_MaxHistoryLength = 20,
	iRTXDI_SpatialNumSamples = 1,
	iRTXDI_SpatialNumDisocclusionBoostSamples = 8,
	fRTXDI_SpatialSamplingRadius = 32.0,
	
	--RayTracing/Reference
	bEnableFixed = true,
	bEnableProbabilisticSampling = false,
	bEnableRIS = true,
	
	--Editor/PathTracing
	bUseScreenSpaceData = false,
	bUseSSRFallback = true,

	--Editor/FoliageParameters
	foliage_ContactShadowClamp = 0.6,
	
	--Editor/ReSTIRGI
	bEnableReSTIRGI = true,
	iEditor_ReSTRIGI_BiasCorrectionMode = 1,
	fReSTIRGI_BoilingFilterStrength = 0.400000,
	bEnableBoilingFilter = false,
	bEnableFallbackSampling = false,
	bEnableFused = true,
	iReSTIRGI_MaxHistoryLength = 8,
	iReSTIRGI_MaxReservoirAge = 32,
	iReSTIRGI_PermutationSamplingMode = 2,
	iReSTIRGI_SpatialNumDisocclusionBoostSamples = 2,
	iReSTIRGI_SpatialNumSamples = 2,
	fReSTIRGI_SpatialSamplingRadius = 32.000000,
	iReSTIRGI_TargetHistoryLength = 8,
	bUseSpatialRGS = true,
	bUseTemporalRGS = false,

	--Editor/ReGIR
	bReGIREnable = false,
	iLightSlotsCount = 128, 
	iShadingCandidatesCount = 4,
	iBuildCandidatesCount = 8,
	bUseForDI = false,
	
    --RayTracing/LocalLight
	iLocalLight_BatchSize = 64,
	iLocalLight_Capacity = 128,
	iLocalLight_GridSize = 16,

	bReferenceAccumulation = false,
	
	bVRS_Enable = true,
	fVRS_VarianceCutoff = 0.025,
	fVRS_MotionFactor = 0.75,
	fVRS_ScreenEdgeFactor = 1.0,

	iBlasCache_Budget = 943718400,
	iBlasCache_Budget_Reserve = 157286400,
	iBlasCache_Budget_display = 900,
	iBlasCache_Budget_Reserve_display = 150
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
		Visuals.InitSettings()
		Visuals.SetDenoiser()
		print(modName..': '..modVer, 'initialized.')
end)
