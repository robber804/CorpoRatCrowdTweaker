local CorpoRat = {}

function CorpoRat.InitSettings()
	--[World/Streaming/PersistencyCache]
	GameOptions.SetInt('World/Streaming/PersistencyCache', 'MaxEntriesPerPage', curSettings.iMaxEntriesPerPage)
	GameOptions.SetInt('World/Streaming/PersistencyCache', 'PoolBudgetKB', curSettings.iPoolBudgetKB)

	--	[ResourceLoaderThrottler]
	GameOptions.SetInt('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', curSettings.iFloodMinNonLoadingThreads)
	GameOptions.SetInt('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', curSettings.iStreamMaxLoadingThreads)
	GameOptions.SetInt('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', curSettings.iTrickleMaxLoadingThreads)

	--Streaming/culling
	GameOptions.SetBool('Streaming/Culling', 'Strict', curSettings.bStrict)

	--Streaming
	GameOptions.SetFloat('Streaming', 'PrecacheDistance', curSettings.fPrecacheDistance)
	GameOptions.SetInt('Streaming', 'MaxNodesPerFrame', curSettings.iMaxNodesPerFrame)
	GameOptions.SetFloat('Streaming', 'MinStreamingDistance', curSettings.fMinStreamingDistance)
	GameOptions.SetFloat('Streaming', 'TimeLimitSectorLoadPerFrame', curSettings.fTimeLimitSectorLoadPerFrame)
	GameOptions.SetFloat('Streaming', 'TimeLimitSectorUnloadPerFrame', curSettings.fTimeLimitSectorUnloadPerFrame)
	GameOptions.SetFloat('Streaming', 'TimeLimitStreamedPerFrame', curSettings.fTimeLimitStreamedPerFrame)
	GameOptions.SetFloat('Streaming', 'RadiusNearSecondaryRefPointAddend', curSettings.fRadiusNearSecondaryRefPointAddend)

	--Streaming/Culling/AutoHideDistanceNear
	GameOptions.SetBool('Streaming/Culling/AutoHideDistanceNear', 'Enabled', curSettings.bStreamingCullingAutoHideDistanceNearEnabled)

	--Rendering
	GameOptions.SetInt('Rendering', 'DistantShadowsMaxBatchSize', curSettings.iDistantShadowsMaxBatchSize)
	GameOptions.SetInt('Rendering', 'DistantShadowsMaxTrianglesPerBatch', curSettings.iDistantShadowsMaxTrianglesPerBatch)
	GameOptions.SetInt('Rendering', 'RainMapBatchMaxSize', curSettings.iRainMapBatchMaxSize)
	GameOptions.SetInt('Rendering', 'RainMapBatchMaxTrianglesPerBatch', curSettings.iRainMapBatchMaxTrianglesPerBatch)
	GameOptions.SetBool('Rendering', 'AllowRTXDIRejitter', curSettings.bAllowRTXDIRejitter)
	GameOptions.SetBool('Rendering', 'AllowRayTracedReferenceRejitter', curSettings.bAllowRayTracedReferenceRejitter)
	GameOptions.SetBool('Rendering', 'DistantGiFix', curSettings.bDistantGiFix)
	GameOptions.SetBool('Rendering', 'GarmentUseSmoothing', curSettings.bGarmentUseSmoothing)
	GameOptions.SetBool('Rendering', 'UseExperimentalVolFog', curSettings.bUseExperimentalVolFog)
	GameOptions.SetBool('Rendering', 'AllowRTXDIRejitter', curSettings.bAllowRTXDIRejitter)
	GameOptions.SetBool('Rendering', 'CheckerboardGI', curSettings.bCheckerboardGI)
	GameOptions.SetInt('Rendering', 'MaxGbufferSplits', curSettings.iMaxGbufferSplits)
	GameOptions.SetFloat('Rendering', 'VolumetricFogVolume_DefaultAbsorption', curSettings.fVolumetricFogVolume_DefaultAbsorption)
 
	--Rendering/LUT
	GameOptions.SetInt('Rendering/LUT', 'Size', curSettings.iLUTSize)
	GameOptions.SetFloat('Rendering/LUT', 'MinRange', tonumber(curSettings.fLUTMinRange))
	GameOptions.SetFloat('Rendering/LUT', 'MaxRange', curSettings.fLUTMaxRange)

	--Editor/PathTracing
	GameOptions.SetBool('Editor/PathTracing', 'UseScreenSpaceData', curSettings.bUseScreenSpaceData)
	GameOptions.SetBool('Editor/PathTracing', 'UseSSRFallback', curSettings.bUseSSRFallback)

	-- Raytracing
	GameOptions.SetBool('RayTracing', 'EnableShadowCascades', curSettings.bEnableShadowCascades)
	GameOptions.SetFloat('RayTracing', 'CullingDistanceCharacter', curSettings.fCullingDistanceCharacter)
	GameOptions.SetFloat('RayTracing', 'CullingDistanceVehicle', curSettings.fCullingDistanceVehicle)
	GameOptions.SetBool('RayTracing', 'EnableImportanceSampling', curSettings.bEnableImportanceSampling)
	GameOptions.SetBool('RayTracing', 'EnableShadowOptimizations', curSettings.bEnableShadowOptimizations)
	GameOptions.SetBool('RayTracing', 'EnableGlobalShadow', curSettings.bEnableGlobalShadow)
	GameOptions.SetBool('RayTracing', 'EnableLocalShadow', curSettings.bEnableLocalShadow)
	GameOptions.SetFloat('RayTracing', 'TracingRadiusReflections', curSettings.fTracingRadiusReflections)
	GameOptions.SetFloat('RayTracing', 'TracingRadius', curSettings.fTracingRadius)
	GameOptions.SetBool('RayTracing', 'EnableAmbientOcclusion', curSettings.bEnableAmbientOcclusion)
	GameOptions.SetBool('RayTracing', 'EnableTransparentReflection', curSettings.bEnableTransparentReflection)
	GameOptions.SetBool('RayTracing', 'EnableDiffuseIllumination', curSettings.bEnableDiffuseIllumination)
	GameOptions.SetBool('RayTracing', 'EnableReflection', curSettings.bEnableReflection)
	GameOptions.SetBool('RayTracing', 'EnableGlobalIllumination', curSettings.bEnableGlobalIllumination)
	GameOptions.SetBool('RayTracing', 'ForceShadowLODBiasUsage', curSettings.bForceShadowLODBiasUsage)
	GameOptions.SetInt('RayTracing', 'ScratchBufferSizeMB', curSettings.iScratchBufferSizeMB)
	GameOptions.SetInt('RayTracing', 'GeometryUpdateBufferSizeMB', curSettings.iGeometryUpdateBufferSizeMB)
	GameOptions.SetInt('RayTracing', 'AccelerationStructureBuildNumMax', curSettings.iAccelerationStructureBuildNumMax)
	GameOptions.SetBool('RayTracing', 'EnableNRD', curSettings.bEnableNRD)
	GameOptions.SetInt('RayTracing', 'MaterialProxyUpdateNumMax', curSettings.iMaterialProxyUpdateNumMax)
	GameOptions.SetInt('RayTracing', 'MaterialProxyNumMax', curSettings.iMaterialProxyNumMax)

	--RayTracing/Reflection
	GameOptions.SetBool('RayTracing/Reflection', 'AdaptiveSampling', curSettings.bReflectionAdaptiveSampling)

	--RayTracing/Diffuse
	GameOptions.SetBool('RayTracing/Diffuse', 'AdaptiveSampling', curSettings.bDiffuseAdaptiveSampling)

	--Developer/FeatureToggles
	GameOptions.SetBool('Developer/FeatureToggles', 'CharacterRimEnhancement', curSettings.bCharacterRimEnhancement)
	GameOptions.SetBool('Developer/FeatureToggles', 'ConstrastAdaptiveSharpening', curSettings.bConstrastAdaptiveSharpening)
	GameOptions.SetBool('Developer/FeatureToggles', 'ContactShadows', curSettings.bContactShadows)
	GameOptions.SetBool('Developer/FeatureToggles', 'ScreenSpaceUnderwater', curSettings.bScreenSpaceUnderwater)
	GameOptions.SetBool('Developer/FeatureToggles', 'VolumetricFog', curSettings.bVolumetricFog)
	GameOptions.SetBool('Developer/FeatureToggles', 'Bloom', curSettings.bBloom)
	GameOptions.SetBool('Developer/FeatureToggles', 'ScreenSpaceHeatHaze', curSettings.bScreenSpaceHeatHaze)
	GameOptions.SetBool('Developer/FeatureToggles', 'RTXDI', curSettings.bRTXDI)
	GameOptions.SetBool('Developer/FeatureToggles', 'ScreenSpaceReflection', curSettings.bScreenSpaceReflection)
	GameOptions.SetBool('Developer/FeatureToggles', 'ScreenSpacePlanarReflection', curSettings.bScreenSpacePlanarReflection)
	GameOptions.SetBool('Developer/FeatureToggles', 'DistantGI', curSettings.bDistantGI)
	GameOptions.SetBool('Developer/FeatureToggles', 'CharacterSubsurfaceScattering', curSettings.bCharacterSubsurfaceScattering)
	GameOptions.SetBool('Developer/FeatureToggles', 'CharacterSubsurfaceTranslucency', curSettings.bCharacterSubsurfaceTranslucency)

	--Editor/Audio/Features
	GameOptions.SetBool('Editor/Audio/Features', 'BreathingSystem', curSettings.bBreathingSystem)

	--Rendering/Shadows
	GameOptions.SetFloat('Rendering/Shadows', 'CascadeRange0', curSettings.fCascadeRange0)
	GameOptions.SetFloat('Rendering/Shadows', 'CascadeRange1', curSettings.fCascadeRange1)
	GameOptions.SetFloat('Rendering/Shadows', 'CascadeRange2', curSettings.fCascadeRange2)
	GameOptions.SetFloat('Rendering/Shadows', 'CascadeRange3', curSettings.fCascadeRange3)
	GameOptions.SetBool('Rendering/Shadows', 'CascadesHeuristicForceRefresh', curSettings.bCascadesHeuristicForceRefresh)
	GameOptions.SetFloat('Rendering/Shadows', 'CascadesHeuristicMinMeshAutohideDistInCascade0', curSettings.fCascadesHeuristicMinMeshAutohideDistInCascade0)
	GameOptions.SetFloat('Rendering/Shadows', 'CascadesHeuristicMinMeshAutohideDistInCascade1', curSettings.fCascadesHeuristicMinMeshAutohideDistInCascade1)
	GameOptions.SetFloat('Rendering/Shadows', 'CascadesHeuristicMinMeshAutohideDistInCascade2', curSettings.fCascadesHeuristicMinMeshAutohideDistInCascade2)
	GameOptions.SetFloat('Rendering/Shadows', 'CascadesHeuristicMinMeshAutohideDistInCascade3', curSettings.fCascadesHeuristicMinMeshAutohideDistInCascade3)
	GameOptions.SetFloat('Rendering/Shadows', 'CascadesHeuristicMinMeshSizeInCascade0', curSettings.fCascadesHeuristicMinMeshSizeInCascade0)
	GameOptions.SetFloat('Rendering/Shadows', 'CascadesHeuristicMinMeshSizeInCascade1', curSettings.fCascadesHeuristicMinMeshSizeInCascade1)
	GameOptions.SetFloat('Rendering/Shadows', 'CascadesHeuristicMinMeshSizeInCascade2', curSettings.fCascadesHeuristicMinMeshSizeInCascade2)
	GameOptions.SetFloat('Rendering/Shadows', 'CascadesHeuristicMinMeshSizeInCascade3', curSettings.fCascadesHeuristicMinMeshSizeInCascade3)
	GameOptions.SetFloat('Rendering/Shadows', 'DistantHeuristicMinMeshAutohideDistInCascade0', curSettings.fDistantHeuristicMinMeshAutohideDistInCascade0)
	GameOptions.SetFloat('Rendering/Shadows', 'DistantHeuristicMinMeshAutohideDistInCascade1', curSettings.fDistantHeuristicMinMeshAutohideDistInCascade1)
	GameOptions.SetFloat('Rendering/Shadows', 'DistantHeuristicMinMeshAutohideDistInCascade2', curSettings.fDistantHeuristicMinMeshAutohideDistInCascade2)
	GameOptions.SetFloat('Rendering/Shadows', 'DistantHeuristicMinMeshSizeInCascade0', curSettings.fDistantHeuristicMinMeshSizeInCascade0)
	GameOptions.SetFloat('Rendering/Shadows', 'DistantHeuristicMinMeshSizeInCascade1', curSettings.fDistantHeuristicMinMeshSizeInCascade1)
	GameOptions.SetFloat('Rendering/Shadows', 'DistantHeuristicMinMeshSizeInCascade2', curSettings.fDistantHeuristicMinMeshSizeInCascade2)
	GameOptions.SetBool('Rendering/Shadows', 'DistantShadowsForceFoliageGeometry', curSettings.bDistantShadowsForceFoliageGeometry)

	--[Editor/SHARC]
	GameOptions.SetInt('Editor/SHARC', 'Bounces', curSettings.iSHARC_Bounces)
	GameOptions.SetInt('Editor/SHARC', 'DownscaleFactor', curSettings.iSHARC_DownscaleFactor)
	GameOptions.SetBool('Editor/SHARC', 'Enable', curSettings.bSHARC_Enable)
	GameOptions.SetFloat('Editor/SHARC', 'SceneScale', curSettings.fSHARC_SceneScale)
	GameOptions.SetBool('Editor/SHARC', 'UseRTXDIAtPrimary', curSettings.bUseRTXDIAtPrimary)
	GameOptions.SetBool('Editor/SHARC', 'UseRTXDIWithAlbedo', curSettings.bUseRTXDIWithAlbedo)
	GameOptions.SetFloat('Editor/SHARC', 'UsePrevFrameBiasAllowance', curSettings.fUsePrevFrameBiasAllowance)
	GameOptions.SetInt('Editor/SHARC', 'HistoryReset', curSettings.iHistoryReset)
	GameOptions.SetBool('Editor/SHARC', 'UsePrevFrame', curSettings.bUsePrevFrame)
	GameOptions.SetBool('Editor/SHARC', 'Clear', curSettings.bClear)

	--Editor/Denoising/NRD
	GameOptions.SetBool('Editor/Denoising/NRD', 'EnableScalingCompensation', curSettings.bEnableScalingCompensation)
	GameOptions.SetBool('RayTracing/NRD', 'UseReblurForDirectRadiance', curSettings.bUseReblurForDirectRadiance)
	GameOptions.SetBool('RayTracing/NRD', 'UseReblurForIndirectRadiance', curSettings.bUseReblurForIndirectRadiance)

	--Editor/Characters/Hair
	GameOptions.SetBool('Editor/Characters/Hair', 'UseReferenceImplementation', curSettings.bUseReferenceImplementation)
	GameOptions.SetFloat('Editor/Characters/Hair', 'AlbedoMultiplier', curSettings.fAlbedoMultiplier)
	GameOptions.SetFloat('Editor/Characters/Hair', 'RoughnessFactor', curSettings.fRoughnessFactor)
	GameOptions.SetFloat('Editor/Characters/Hair', 'AdditionalAreaRoughness', curSettings.fAdditionalAreaRoughness)
	GameOptions.SetFloat('Editor/Characters/Hair', 'SpecularRandom_Min', curSettings.fSpecularRandom_Min)
	GameOptions.SetFloat('Editor/Characters/Hair', 'SpecularRandom_Max', curSettings.fSpecularRandom_Max)
	GameOptions.SetBool('Editor/Characters/Hair', 'UseGlobalContactShadowsOnHair', curSettings.bUseGlobalContactShadowsOnHair)
	GameOptions.SetFloat('Editor/Characters/Hair', 'ContactShadowClamp', curSettings.fContactShadowClamp)

	GameOptions.SetFloat('Editor/FoliageParameters', 'ContactShadowClamp', curSettings.foliage_ContactShadowClamp)

	--[Editor/Characters/Hair/Specular]
	GameOptions.SetFloat('Editor/Characters/Hair/Specular', 'Wrap', curSettings.fECHS_Wrap)
	GameOptions.SetFloat('Editor/Characters/Hair/Specular', 'Mask_Intensity', curSettings.fECHS_Mask_Intensity)

	--[Editor/Characters/Hair/MultiScatter]
	GameOptions.SetFloat('Editor/Characters/Hair/MultiScatter', 'Wrap', curSettings.fECHM_Wrap)
	GameOptions.SetFloat('Editor/Characters/Hair/MultiScatter', 'Mask_Intensity', curSettings.fECHM_Mask_Intensity)
	GameOptions.SetFloat('Editor/Characters/Hair/MultiScatter', 'DiffuseScatterFactor', curSettings.fECHM_DiffuseScatterFactor)

	--[Editor/Characters/Hair/EnvProbe]
	GameOptions.SetFloat('Editor/Characters/Hair/EnvProbe', 'R', curSettings.fECHE_R)
	GameOptions.SetFloat('Editor/Characters/Hair/EnvProbe', 'TT', curSettings.fECHE_TT)
	GameOptions.SetFloat('Editor/Characters/Hair/EnvProbe', 'TRT', curSettings.fECHE_TRT)
	GameOptions.SetFloat('Editor/Characters/Hair/EnvProbe', 'MultiScatter', curSettings.fECHE_MultiScatter)
	GameOptions.SetFloat('Editor/Characters/Hair/EnvProbe', 'ScatterDepth', curSettings.fECHE_ScatterDepth)

	--[Editor/Characters/Hair/LocalLight]
	GameOptions.SetFloat('Editor/Characters/Hair/LocalLight', 'R', curSettings.fECHL_R)
	GameOptions.SetFloat('Editor/Characters/Hair/LocalLight', 'TT', curSettings.fECHL_TT)
	GameOptions.SetFloat('Editor/Characters/Hair/LocalLight', 'TRT', curSettings.fECHL_TRT)
	GameOptions.SetFloat('Editor/Characters/Hair/LocalLight', 'MultiScatter', curSettings.fECHL_MultiScatter)
	GameOptions.SetFloat('Editor/Characters/Hair/LocalLight', 'ScatterDepth', curSettings.fECHL_ScatterDepth)

	--[Editor/Characters/Hair/GlobalLight]
	GameOptions.SetFloat('Editor/Characters/Hair/GlobalLight', 'R', curSettings.fECHG_R)
	GameOptions.SetFloat('Editor/Characters/Hair/GlobalLight', 'TT', curSettings.fECHG_TT)
	GameOptions.SetFloat('Editor/Characters/Hair/GlobalLight', 'TRT', curSettings.fECHG_TRT)
	GameOptions.SetFloat('Editor/Characters/Hair/GlobalLight', 'MultiScatter', curSettings.fECHG_MultiScatter)
	GameOptions.SetFloat('Editor/Characters/Hair/GlobalLight', 'ScatterDepth', curSettings.fECHG_ScatterDepth)

	--[Editor/Characters/Hair/AlphaShifts]
	GameOptions.SetFloat('Editor/Characters/Hair/AlphaShifts', 'R', curSettings.fECHA_R)
	GameOptions.SetFloat('Editor/Characters/Hair/AlphaShifts', 'TT', curSettings.fECHA_TT)
	GameOptions.SetFloat('Editor/Characters/Hair/AlphaShifts', 'TRT', curSettings.fECHA_TRT)

	--[Editor/Characters/Hair/HACKS]
	GameOptions.SetFloat('Editor/Characters/Hair/HACKS', 'HACK_Factor0', curSettings.fECHH_HACK_Factor0)
	GameOptions.SetFloat('Editor/Characters/Hair/HACKS', 'HACK_Factor1', curSettings.fECHH_HACK_Factor1)
	GameOptions.SetFloat('Editor/Characters/Hair/HACKS', 'HACK_Factor2', curSettings.fECHH_HACK_Factor2)
	GameOptions.SetFloat('Editor/Characters/Hair/HACKS', 'HACK_Factor3', curSettings.fECHH_HACK_Factor3)
	GameOptions.SetBool('Editor/Characters/Hair/HACKS', 'AAAA_HACK_hairModifiedLocalLightIntensity', curSettings.bECHH_AAAA_HACK_hairModifiedLocalLightIntensity)

	--[Editor/Characters/Hair/TRT_Params]
	GameOptions.SetFloat('Editor/Characters/Hair/TRT_Params', 'EXP_SCALE', curSettings.fTRT_Params_EXP_SCALE)
	GameOptions.SetFloat('Editor/Characters/Hair/TRT_Params', 'EXP_BIAS', curSettings.fTRT_Params_EXP_BIAS)

	--[Editor/Characters/Skin]
	GameOptions.SetBool('Editor/Characters/Skin', 'AllowSkinAmbientMix', curSettings.bECS_AllowSkinAmbientMix)
	GameOptions.SetFloat('Editor/Characters/Skin', 'SkinAmbientMix_Factor', curSettings.fECS_SkinAmbientMix_Factor)
	GameOptions.SetFloat('Editor/Characters/Skin', 'SubsurfaceSpecularTintWeight', curSettings.fECS_SubsurfaceSpecularTintWeight)
	GameOptions.SetFloat('Editor/Characters/Skin', 'SkinAmbientIntensity_Factor', curSettings.fECS_SkinAmbientIntensity_Factor)
	GameOptions.SetFloat('Editor/Characters/Skin', 'SubsurfaceSpecularTint_R', curSettings.fECS_SubsurfaceSpecularTint_R)
	GameOptions.SetFloat('Editor/Characters/Skin', 'SubsurfaceSpecularTint_G', curSettings.fECS_SubsurfaceSpecularTint_G)
	GameOptions.SetFloat('Editor/Characters/Skin', 'SubsurfaceSpecularTint_B', curSettings.fECS_SubsurfaceSpecularTint_B)

	--[Editor/Characters/Eyes]
	GameOptions.SetFloat('Editor/Characters/Eyes', 'DiffuseBoost', curSettings.fECE_DiffuseBoost)
	GameOptions.SetBool('Editor/Characters/Eyes', 'UseAOOnEyes', curSettings.bUseAOOnEyes)

	--[DLSS]
	GameOptions.SetInt('DLSS', 'SampleNumber', curSettings.iDLSS_SampleNumber)
	GameOptions.SetBool('DLSS', 'EnableHalton', curSettings.bEnableHalton)

	--[Editor/RTXDI]
	GameOptions.SetBool('Editor/RTXDI', 'EnableLocalLightImportanceSampling', curSettings.bEnableLocalLightImportanceSampling)
	GameOptions.SetBool('Editor/RTXDI', 'EnableSeparateDenoising', curSettings.bEnableSeparateDenoising)
	GameOptions.SetBool('Editor/RTXDI', 'EnableFallbackLight', curSettings.bEnableFallbackLight)
	GameOptions.SetFloat('Editor/RTXDI', 'ShadowFadeFraction', curSettings.fShadowFadeFraction)
	GameOptions.SetBool('Editor/RTXDI', 'EnableApproximateTargetPDF', curSettings.bEnableApproximateTargetPDF)
	GameOptions.SetBool('Editor/RTXDI', 'EnableGradients', curSettings.bEnableGradients)
	GameOptions.SetBool('Editor/RTXDI', 'UseCustomDenoiser', curSettings.bUseCustomDenoiser)
	GameOptions.SetBool('Editor/RTXDI', 'EnableRTXDIDenoising', curSettings.bEnableRTXDIDenoising)
	GameOptions.SetBool('Editor/RTXDI', 'InitialCandidatesInTemporal', curSettings.bInitialCandidatesInTemporal)
	GameOptions.SetInt('Editor/RTXDI', 'BiasCorrectionMode', (tonumber(curSettings.iRTXDI_BiasCorrectionMode)-1))
	GameOptions.SetInt('Editor/RTXDI', 'PermutationSamplingMode', (tonumber(curSettings.iRTXDI_PermutationSamplingMode)-1))
	GameOptions.SetFloat('Editor/RTXDI', 'BoilingFilterStrength', curSettings.fRTXDI_BoilingFilterStrength)
	GameOptions.SetInt('Editor/RTXDI', 'MaxHistoryLength', curSettings.iRTXDI_MaxHistoryLength)
	GameOptions.SetInt('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', curSettings.iRTXDI_SpatialNumDisocclusionBoostSamples)
	GameOptions.SetInt('Editor/RTXDI', 'SpatialNumSamples', curSettings.iRTXDI_SpatialNumSamples)
	GameOptions.SetInt('Editor/RTXDI', 'NumInitialSamples', curSettings.iRTXDI_NumInitialSamples)
	GameOptions.SetInt('Editor/RTXDI', 'NumEnvMapSamples', curSettings.iRTXDI_NumEnvMapSamples)
	GameOptions.SetFloat('Editor/RTXDI', 'SpatialSamplingRadius', curSettings.fRTXDI_SpatialSamplingRadius)
	GameOptions.SetFloat('Editor/RTXDI', 'ForcedShadowLightSourceRadius', curSettings.fForcedShadowLightSourceRadius)
	GameOptions.SetBool('Editor/RTXDI', 'ForceAllShadows', curSettings.bForceAllShadows)

	--[RayTracing/Reference]
	GameOptions.SetBool('RayTracing/Reference', 'EnableProbabilisticSampling', curSettings.bEnableProbabilisticSampling)
	GameOptions.SetBool('RayTracing/Reference', 'EnableRIS', curSettings.bEnableRIS)
	GameOptions.SetBool('RayTracing/Reference', 'EnableFixed', curSettings.bEnableFixed)
	GameOptions.SetFloat('RayTracing/Reference', 'AlbedoModulation', 0)
	GameOptions.SetFloat('RayTracing/Reference', 'DiffuseEmissiveScale', 1.0)
	GameOptions.SetFloat('RayTracing/Reference', 'DiffuseGlobalScale', 1.0)
	GameOptions.SetFloat('RayTracing/Reference', 'DiffuseLocalLightsScale', 1.0)
	GameOptions.SetFloat('RayTracing/Reference', 'DiffuseSkyScale', 1.1)
	GameOptions.SetFloat('RayTracing/Reference', 'DiffuseSunScale', 1.35)
	GameOptions.SetFloat('RayTracing/Reference', 'MaxIntensity', 1000.0)
	GameOptions.SetFloat('RayTracing/Reference', 'SpecularEmissiveScale', 1.0)
	GameOptions.SetFloat('RayTracing/Reference', 'SpecularGlobalScale', 1.0)
	GameOptions.SetFloat('RayTracing/Reference', 'SpecularLocalLightsScale', 1.0)
	GameOptions.SetFloat('RayTracing/Reference', 'SpecularSkyScale', 1.0)
	GameOptions.SetFloat('RayTracing/Reference', 'SpecularSunScale', 1.0)
	GameOptions.SetFloat('RayTracing/Reference', 'GIOnlyLightScale', 1.1)

	GameOptions.SetFloat('Editor/Denoising/ReBLUR', 'HitDistanceRoughnessScale', 10.0)
	GameOptions.SetFloat('Editor/Denoising/ReBLUR', 'HitDistanceRoughnessExpScale', -1.0)

	GameOptions.SetBool('Occlusion', 'MultiFrustumUseGlobalOcclusion', false)
	GameOptions.SetBool('RayTracing/DynamicInstance', 'UpdateUseHalfFloat', false)

	GameOptions.SetFloat('Rendering/MeshLoading', 'AutoRefreshTime', 0.1)

	GameOptions.SetFloat('SnapToTerrainIk', 'TraceAboveGroundDistance', 1.0)
	GameOptions.SetFloat('SnapToTerrainIk', 'TraceBelowGroundDistance', 1.0)

	--[Editor/ReSTIRGI]
	GameOptions.SetBool('Editor/ReSTIRGI', 'Enable', curSettings.bEnableReSTIRGI)
	GameOptions.SetBool('Editor/ReSTIRGI', 'EnableFallbackSampling', curSettings.bEnableFallbackSampling)
	GameOptions.SetBool('Editor/ReSTIRGI', 'UseTemporalRGS', curSettings.bUseTemporalRGS)
	GameOptions.SetBool('Editor/ReSTIRGI', 'UseSpatialRGS', curSettings.bUseSpatialRGS)
	GameOptions.SetBool('Editor/ReSTIRGI', 'EnableFused', curSettings.bEnableFused)
	GameOptions.SetBool('Editor/ReSTIRGI', 'EnableBoilingFilter', curSettings.bEnableBoilingFilter)
	GameOptions.SetInt('Editor/ReSTIRGI', 'BiasCorrectionMode', (tonumber(curSettings.iEditor_ReSTRIGI_BiasCorrectionMode)-1))
	GameOptions.SetInt('Editor/ReSTIRGI', 'PermutationSamplingMode', (tonumber(curSettings.iReSTIRGI_PermutationSamplingMode)-1))
	GameOptions.SetFloat('Editor/ReSTIRGI', 'BoilingFilterStrength', curSettings.fReSTIRGI_BoilingFilterStrength)
	GameOptions.SetInt('Editor/ReSTIRGI', 'MaxHistoryLength', curSettings.iReSTIRGI_MaxHistoryLength)
	GameOptions.SetInt('Editor/ReSTIRGI', 'MaxReservoirAge', curSettings.iReSTIRGI_MaxReservoirAge)
	GameOptions.SetInt('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', curSettings.iReSTIRGI_SpatialNumDisocclusionBoostSamples)
	GameOptions.SetInt('Editor/ReSTIRGI', 'SpatialNumSamples', curSettings.iReSTIRGI_SpatialNumSamples)
	GameOptions.SetInt('Editor/ReSTIRGI', 'TargetHistoryLength', curSettings.iReSTIRGI_TargetHistoryLength)
	GameOptions.SetFloat('Editor/ReSTIRGI', 'SpatialSamplingRadius', curSettings.fReSTIRGI_SpatialSamplingRadius)

	--[RayTracing/LocalLight]
	GameOptions.SetInt('RayTracing/LocalLight', 'BatchSize', curSettings.iLocalLight_BatchSize)
	GameOptions.SetInt('RayTracing/LocalLight', 'Capacity', curSettings.iLocalLight_Capacity)
	GameOptions.SetInt('RayTracing/LocalLight', 'GridSize', curSettings.iLocalLight_GridSize)

	--[RayTracing/BlasCache]
	GameOptions.SetInt('RayTracing/BlasCache', 'Budget', curSettings.iBlasCache_Budget)
	GameOptions.SetInt('RayTracing/BlasCache', 'Reserve', curSettings.iBlasCache_Reserve)

	--Editor/Denoising/ReBLUR/Direct/
	GameOptions.SetBool('Editor/Denoising/ReBLUR/Direct', 'ReferenceAccumulation', curSettings.bReBLUR_ReferenceAccumulation)

	--VariableRateShading
	GameOptions.SetBool('Rendering/VariableRateShading', 'Enable', curSettings.bVRS_Enable)
	GameOptions.SetFloat('Rendering/VariableRateShading', 'VarianceCutoff', curSettings.fVRS_VarianceCutoff)
	GameOptions.SetFloat('Rendering/VariableRateShading', 'MotionFactor', curSettings.fVRS_MotionFactor)
	GameOptions.SetFloat('Rendering/VariableRateShading', 'ScreenEdgeFactor', curSettings.fVRS_ScreenEdgeFactor)

	--[Editor/ReGIR]
	GameOptions.SetBool('Editor/ReGIR', 'Enable', curSettings.bReGIREnable)
	GameOptions.SetInt('Editor/ReGIR', 'LightSlotsCount', curSettings.iLightSlotsCount)
	GameOptions.SetInt('Editor/ReGIR', 'BuildCandidatesCount', curSettings.iBuildCandidatesCount)
	GameOptions.SetBool('Editor/ReGIR', 'UseForDI', curSettings.bUseForDI)

--	Print('CorpoRat.InitSettings Ran')
end

function CorpoRat.SetDenoiser()
	
	if curSettings.denoiser == 1 then
		--clean
		GameOptions.SetFloat('Editor/Denoising/NRD', 'DisocclusionThreshold', 0.01)

		GameOptions.SetInt('Editor/Denoising/ReBLUR/Direct', 'HistoryFixFrameNum', 3)
		GameOptions.SetInt('Editor/Denoising/ReBLUR/Indirect', 'HistoryFixFrameNum', 3)
		GameOptions.SetFloat('Editor/Denoising/ReBLUR/Direct', 'HistoryFixStrength', 0.5)
		GameOptions.SetFloat('Editor/Denoising/ReBLUR/Indirect', 'HistoryFixStrength', 0.5)

		GameOptions.SetBool('Editor/Denoising/ReLAX/Direct/Common', 'AntiFirefly', false)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Common', 'HistoryFixFrameNum', 2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Common', 'HistoryFixEdgeStoppingNormalPower', 8.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Common', 'HistoryClampingColorBoxSigmaScale', 1.5)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Common', 'AtrousIterationNum', 2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Common', 'DepthThreshold', 0.0015)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Diffuse', 'PrepassBlurRadius', 12.5)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Diffuse', 'MaxAccumulatedFrameNum', 16)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Diffuse', 'MaxFastAccumulatedFrameNum', 3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Diffuse', 'PhiLuminance', 0.1)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Diffuse', 'LobeAngleFraction', 0.25)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'PrepassBlurRadius', 25.0)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Specular', 'MaxAccumulatedFrameNum', 16)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Specular', 'MaxFastAccumulatedFrameNum', 2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'PhiLuminance', 0.15)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'LobeAngleFraction', 0.125)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'RoughnessFraction', 0.75)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'LobeAngleSlack', 0.05)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'LuminanceEdgeStoppingRelaxation', 0.25)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'NormalEdgeStoppingRelaxation', 0.15)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'RoughnessEdgeStoppingRelaxation', 0.15)
		GameOptions.SetBool('Editor/Denoising/ReLAX/Direct/Specular', 'VirtualHistoryClamping', true)

		GameOptions.SetBool('Editor/Denoising/ReLAX/Indirect/Common', 'AntiFirefly', false)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Common', 'HistoryFixFrameNum', 2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Common', 'HistoryFixEdgeStoppingNormalPower', 2.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Common', 'HistoryClampingColorBoxSigmaScale', 1.5)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Common', 'AtrousIterationNum', 2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Common', 'DepthThreshold', 0.005)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Diffuse', 'PrepassBlurRadius', 12.5)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Diffuse', 'MaxAccumulatedFrameNum', 32)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Diffuse', 'MaxFastAccumulatedFrameNum', 4)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Diffuse', 'PhiLuminance', 0.5)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Diffuse', 'LobeAngleFraction', 0.5)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'PrepassBlurRadius', 25.0)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Specular', 'MaxAccumulatedFrameNum', 3)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Specular', 'MaxFastAccumulatedFrameNum', 3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'PhiLuminance', 0.5)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'LobeAngleFraction', 0.5)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'RoughnessFraction', 0.15)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'LobeAngleSlack', 0.1)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'LuminanceEdgeStoppingRelaxation', 0.25)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'NormalEdgeStoppingRelaxIation', 0.15)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'RoughnessEdgeStoppingRelaxation', 0.15)
		GameOptions.SetBool('Editor/Denoising/ReLAX/Indirect/Specular', 'VirtualHistoryClamping', true)
--		Print("Set Denoiser to Ray Reconstruction Clean")
	end
	
	if curSettings.denoiser == 2 then
		--sharp
		GameOptions.SetFloat('Editor/Denoising/NRD', 'DisocclusionThreshold', 0.0)

		GameOptions.SetInt('Editor/Denoising/ReBLUR/Direct', 'HistoryFixFrameNum', 3)
		GameOptions.SetInt('Editor/Denoising/ReBLUR/Indirect', 'HistoryFixFrameNum', 3)
		GameOptions.SetFloat('Editor/Denoising/ReBLUR/Direct', 'HistoryFixStrength', 0.5)
		GameOptions.SetFloat('Editor/Denoising/ReBLUR/Indirect', 'HistoryFixStrength', 0.5)

		GameOptions.SetBool('Editor/Denoising/ReLAX/Direct/Common', 'AntiFirefly', false)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Common', 'HistoryFixFrameNum', 2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Common', 'HistoryFixEdgeStoppingNormalPower', 8.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Common', 'HistoryClampingColorBoxSigmaScale', 2.5)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Common', 'AtrousIterationNum', 2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Common', 'DepthThreshold', 0.0015)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Diffuse', 'PrepassBlurRadius', 12.5)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Diffuse', 'MaxAccumulatedFrameNum', 12)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Diffuse', 'MaxFastAccumulatedFrameNum', 2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Diffuse', 'PhiLuminance', 0.1)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Diffuse', 'LobeAngleFraction', 0.0)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'PrepassBlurRadius', 25.0)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Specular', 'MaxAccumulatedFrameNum', 12)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Specular', 'MaxFastAccumulatedFrameNum', 2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'PhiLuminance', 0.1)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'LobeAngleFraction', 0.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'RoughnessFraction', 0.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'LobeAngleSlack', 0.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'LuminanceEdgeStoppingRelaxation', 0.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'NormalEdgeStoppingRelaxation', 0.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'RoughnessEdgeStoppingRelaxation', 0.0)
		GameOptions.SetBool('Editor/Denoising/ReLAX/Direct/Specular', 'VirtualHistoryClamping', false)

		GameOptions.SetBool('Editor/Denoising/ReLAX/Indirect/Common', 'AntiFirefly', false)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Common', 'HistoryFixFrameNum', 2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Common', 'HistoryFixEdgeStoppingNormalPower', 2.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Common', 'HistoryClampingColorBoxSigmaScale', 2.5)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Common', 'AtrousIterationNum', 2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Common', 'DepthThreshold', 0.0045)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Diffuse', 'PrepassBlurRadius', 12.5)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Diffuse', 'MaxAccumulatedFrameNum', 16)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Diffuse', 'MaxFastAccumulatedFrameNum', 3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Diffuse', 'PhiLuminance', 0.5)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Diffuse', 'LobeAngleFraction', 0.0)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'PrepassBlurRadius', 25.0)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Specular', 'MaxAccumulatedFrameNum', 16)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Specular', 'MaxFastAccumulatedFrameNum', 3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'PhiLuminance', 0.5)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'LobeAngleFraction', 0.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'RoughnessFraction', 0.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'LobeAngleSlack', 0.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'LuminanceEdgeStoppingRelaxation', 0.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'NormalEdgeStoppingRelaxIation', 0.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'RoughnessEdgeStoppingRelaxation', 0.0)
		GameOptions.SetBool('Editor/Denoising/ReLAX/Indirect/Specular', 'VirtualHistoryClamping', false)
--		Print("Set Denoiser to Ray Reconstruction Sharp")
	end
	
	if curSettings.denoiser == 3 then
		--NRD
		GameOptions.SetBool('Editor/RTXDI', 'EnableGradients', false)

		GameOptions.SetFloat('Editor/Denoising/NRD', 'DisocclusionThreshold', 0.01)

		GameOptions.SetInt('Editor/Denoising/ReBLUR/Direct', 'HistoryFixFrameNum', 5)
		GameOptions.SetInt('Editor/Denoising/ReBLUR/Indirect', 'HistoryFixFrameNum', 5)
		GameOptions.SetFloat('Editor/Denoising/ReBLUR/Direct', 'HistoryFixStrength', 1.0)
		GameOptions.SetFloat('Editor/Denoising/ReBLUR/Indirect', 'HistoryFixStrength', 1.0)

		GameOptions.SetBool('Editor/Denoising/ReLAX/Direct/Common', 'AntiFirefly', true)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Common', 'HistoryFixFrameNum', 3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Common', 'HistoryFixEdgeStoppingNormalPower', 8.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Common', 'HistoryClampingColorBoxSigmaScale', 2.0)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Common', 'AtrousIterationNum', 5)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Common', 'DepthThreshold', 0.003)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Diffuse', 'PrepassBlurRadius', 12.5)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Diffuse', 'MaxAccumulatedFrameNum', 16)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Diffuse', 'MaxFastAccumulatedFrameNum', 1)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Diffuse', 'PhiLuminance', 0.2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Diffuse', 'LobeAngleFraction', 0.5)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'PrepassBlurRadius', 25.0)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Specular', 'MaxAccumulatedFrameNum', 16)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Specular', 'MaxFastAccumulatedFrameNum', 1)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'PhiLuminance', 0.3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'LobeAngleFraction', 0.25)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'RoughnessFraction', 0.15)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'LobeAngleSlack', 0.05)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'LuminanceEdgeStoppingRelaxation', 0.5)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'NormalEdgeStoppingRelaxation', 0.3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'RoughnessEdgeStoppingRelaxation', 0.3)
		GameOptions.SetBool('Editor/Denoising/ReLAX/Direct/Specular', 'VirtualHistoryClamping', true)

		GameOptions.SetBool('Editor/Denoising/ReLAX/Indirect/Common', 'AntiFirefly', true)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Common', 'HistoryFixFrameNum', 3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Common', 'HistoryFixEdgeStoppingNormalPower', 1.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Common', 'HistoryClampingColorBoxSigmaScale', 2.0)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Common', 'AtrousIterationNum', 7)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Common', 'DepthThreshold', 0.01)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Diffuse', 'PrepassBlurRadius', 12.5)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Diffuse', 'MaxAccumulatedFrameNum', 32)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Diffuse', 'MaxFastAccumulatedFrameNum', 2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Diffuse', 'PhiLuminance', 1.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Diffuse', 'LobeAngleFraction', 1.0)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'PrepassBlurRadius', 25.0)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Specular', 'MaxAccumulatedFrameNum', 32)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Specular', 'MaxFastAccumulatedFrameNum', 2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'PhiLuminance', 1.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'LobeAngleFraction', 0.5)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'RoughnessFraction', 0.3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'LobeAngleSlack', 0.1)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'LuminanceEdgeStoppingRelaxation', 0.5)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'NormalEdgeStoppingRelaxIation', 0.3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'RoughnessEdgeStoppingRelaxation', 0.3)
		GameOptions.SetBool('Editor/Denoising/ReLAX/Indirect/Specular', 'VirtualHistoryClamping', true)
--		Print("Set Denoiser to NRD")
	end

	if curSettings.denoiser == 4 then
		--Vanilla
		GameOptions.SetBool('Editor/RTXDI', 'EnableGradients', true)

		GameOptions.SetFloat('Editor/Denoising/NRD', 'DisocclusionThreshold', 0.005)

		GameOptions.SetInt('Editor/Denoising/ReBLUR/Direct', 'HistoryFixFrameNum', 3)
		GameOptions.SetInt('Editor/Denoising/ReBLUR/Indirect', 'HistoryFixFrameNum', 3)
		GameOptions.SetFloat('Editor/Denoising/ReBLUR/Direct', 'HistoryFixStrength', 1.0)
		GameOptions.SetFloat('Editor/Denoising/ReBLUR/Indirect', 'HistoryFixStrength', 1.0)

		GameOptions.SetBool('Editor/Denoising/ReLAX/Direct/Common', 'AntiFirefly', true)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Common', 'HistoryFixFrameNum', 3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Common', 'HistoryFixEdgeStoppingNormalPower', 8.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Common', 'HistoryClampingColorBoxSigmaScale', 2.0)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Common', 'AtrousIterationNum', 5)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Common', 'DepthThreshold', 0.003)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Diffuse', 'PrepassBlurRadius', 25.0)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Diffuse', 'MaxAccumulatedFrameNum', 24)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Diffuse', 'MaxFastAccumulatedFrameNum', 2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Diffuse', 'PhiLuminance', 0.2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Diffuse', 'LobeAngleFraction', 0.5)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'PrepassBlurRadius', 50.0)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Specular', 'MaxAccumulatedFrameNum', 24)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Direct/Specular', 'MaxFastAccumulatedFrameNum', 2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'PhiLuminance', 0.3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'LobeAngleFraction', 0.25)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'RoughnessFraction', 0.15)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'LobeAngleSlack', 0.1)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'LuminanceEdgeStoppingRelaxation', 0.5)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'NormalEdgeStoppingRelaxation', 0.3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Direct/Specular', 'RoughnessEdgeStoppingRelaxation', 0.3)
		GameOptions.SetBool('Editor/Denoising/ReLAX/Direct/Specular', 'VirtualHistoryClamping', true)

		GameOptions.SetBool('Editor/Denoising/ReLAX/Indirect/Common', 'AntiFirefly', true)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Common', 'HistoryFixFrameNum', 3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Common', 'HistoryFixEdgeStoppingNormalPower', 1.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Common', 'HistoryClampingColorBoxSigmaScale', 2.0)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Common', 'AtrousIterationNum', 5)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Common', 'DepthThreshold', 0.01)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Diffuse', 'PrepassBlurRadius', 25.0)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Diffuse', 'MaxAccumulatedFrameNum', 48)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Diffuse', 'MaxFastAccumulatedFrameNum', 3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Diffuse', 'PhiLuminance', 1.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Diffuse', 'LobeAngleFraction', 1.0)

		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'PrepassBlurRadius', 50.0)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Specular', 'MaxAccumulatedFrameNum', 48)
		GameOptions.SetInt('Editor/Denoising/ReLAX/Indirect/Specular', 'MaxFastAccumulatedFrameNum', 3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'PhiLuminance', 1.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'LobeAngleFraction', 1.0)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'RoughnessFraction', 0.3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'LobeAngleSlack', 0.2)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'LuminanceEdgeStoppingRelaxation', 0.5)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'NormalEdgeStoppingRelaxIation', 0.3)
		GameOptions.SetFloat('Editor/Denoising/ReLAX/Indirect/Specular', 'RoughnessEdgeStoppingRelaxation', 0.3)
		GameOptions.SetBool('Editor/Denoising/ReLAX/Indirect/Specular', 'VirtualHistoryClamping', false)
--		Print("Set Denoiser to Vanilla")
	end
end
	
return CorpoRat