CORPORAT = {}

local config = require("Modules/config")
local config = require("Modules/functions")
local Visuals = require("Modules/functions")

local nativeSettings = GetMod("nativeSettings")

local LUTlist = {[1] = "0.000000000001", [2] = "0.00000000001", [3] = "0.0000000001", [4] = "0.000000001", [5] = "0.00000001", [6] = "0.0000001", [7] = "0.000001", [8] = "0.00001", [9] = "0.0001", [10] = "0.001" }

local  Denoiser_list = {[1] = "Ray Reconstruction (clean)", [2] = "Ray Reconstruction (sharp)", [3] = "NRD/DLSS", [4] = "Vanilla"}

local bias_list = {[1] = "None", [2] = "Basic", [3] = "Full" }

local permutaion_list = {[1] = "Random", [2] = "Deterministic", [3] = "Advanced" }

nativeSettings.addTab("/CORPORAT", "CorpoRat: Graphics Settings")

nativeSettings.addSubcategory("/CORPORAT/Denoiser", "Denoiser")

nativeSettings.addSubcategory("/CORPORAT/PersistencyCache", "World/Streaming/PersistencyCache")

nativeSettings.addSubcategory("/CORPORAT/ResourceLoaderThrottler", "Resource Loader Throttler")

nativeSettings.addSubcategory("/CORPORAT/Streaming", "Streaming")
nativeSettings.addSubcategory("/CORPORAT/StreamingCulling", "Streaming/Culling")

nativeSettings.addSubcategory("/CORPORAT/DLSS", "DLSS")

nativeSettings.addSubcategory("/CORPORAT/FeatureToggles", "Developer/FeatureToggles")

nativeSettings.addSubcategory("/CORPORAT/Rendering", "Rendering")
nativeSettings.addSubcategory("/CORPORAT/Shadows", "Rendering/Shadows")
nativeSettings.addSubcategory("/CORPORAT/LUT", "Rendering/LUT")
nativeSettings.addSubcategory("/CORPORAT/VRS", "Rendering/VariableRateShading")

nativeSettings.addSubcategory("/CORPORAT/RayTracing", "RayTracing")
nativeSettings.addSubcategory("/CORPORAT/BlasCache", "RayTracing/BlasCache")
nativeSettings.addSubcategory("/CORPORAT/Reflection", "RayTracing/Reflection")
nativeSettings.addSubcategory("/CORPORAT/Diffuse", "RayTracing/Diffuse")
nativeSettings.addSubcategory("/CORPORAT/LocalLight", "RayTracing/LocalLight")
nativeSettings.addSubcategory("/CORPORAT/Reference", "RayTracing/Reference")

nativeSettings.addSubcategory("/CORPORAT/PathTracing", "Editor/PathTracing")
nativeSettings.addSubcategory("/CORPORAT/RTXDI", "Editor/RTXDI")
nativeSettings.addSubcategory("/CORPORAT/ReSTIRGI", "Editor/ReSTIRGI")
nativeSettings.addSubcategory("/CORPORAT/ReGIR", "Editor/ReGIR")
nativeSettings.addSubcategory("/CORPORAT/SHARC", "Editor/SHARC - Spatially Hashed Radiance Cache (SHaRC)")
nativeSettings.addSubcategory("/CORPORAT/NRD", "Editor/Denoising/NRD")
nativeSettings.addSubcategory("/CORPORAT/ReBLUR", "Editor/Denoising/ReBLUR/Direct")
nativeSettings.addSubcategory("/CORPORAT/Audio", "Editor/Audio/Features")
nativeSettings.addSubcategory("/CORPORAT/FoliageParameters", "Editor/FoliageParameters")

nativeSettings.addSubcategory("/CORPORAT/Skin1", "Editor/Characters/Skin")

nativeSettings.addSubcategory("/CORPORAT/Eyes", "Editor/Characters/Eyes")

nativeSettings.addSubcategory("/CORPORAT/Hair", "Editor/Characters/Hair")
nativeSettings.addSubcategory("/CORPORAT/HairSpecular", "Editor/Characters/Hair/Specular")
nativeSettings.addSubcategory("/CORPORAT/HairMultiScatter", "Editor/Characters/Hair/MultiScatter")
nativeSettings.addSubcategory("/CORPORAT/HairEnvProbe", "Editor/Characters/Hair/EnvProbe")
nativeSettings.addSubcategory("/CORPORAT/HairLocalLight", "Editor/Characters/Hair/LocalLight")
nativeSettings.addSubcategory("/CORPORAT/HairGlobalLight", "Editor/Characters/Hair/GlobalLight")
nativeSettings.addSubcategory("/CORPORAT/HairAlphaShifts", "Editor/Characters/Hair/AlphaShifts")
nativeSettings.addSubcategory("/CORPORAT/HairHacks", "Editor/Characters/Hair/HACKS")
nativeSettings.addSubcategory("/CORPORAT/TRT_Params", "Editor/Characters/Hair/TRT_Params")


function CORPORAT:new()

    nativeSettings.addSelectorString("/CORPORAT/Denoiser", "Denoiser Preset", "Ray Reconstruction, NRD, Vanilla", Denoiser_list, curSettings.denoiser, defaultSettings.denoiser, function(value)
        curSettings.denoiser = tonumber(value)
--		print("SetDenoiser Updated to ", Denoiser_list[value])
--		print("SetDenoiser Updated to ", value)
        SaveFile("Data/config.json", curSettings)
		Visuals.SetDenoiser()
--		print("Visuals.SetDenoiser Ran")
    end)

--[World/Streaming/PersistencyCache]
    nativeSettings.addRangeInt("/CORPORAT/PersistencyCache", "Max Entries Per Page", "Max Entries Per Page (Default: 8)", 8, 64, 8, curSettings.iMaxEntriesPerPage, defaultSettings.iMaxEntriesPerPage, function(state)
        curSettings.iMaxEntriesPerPage = state
		GameOptions.SetInt('World/Streaming/PersistencyCache', 'MaxEntriesPerPage', state)
    end)

    nativeSettings.addRangeInt("/CORPORAT/PersistencyCache", "Pool Budget in Kilobytes", "This is the memory budget (in kilobytes) allocated for the streaming pool (Default: 4096)", 4096, 16384, 4096, curSettings.iPoolBudgetKB, defaultSettings.iPoolBudgetKB, function(state)
        curSettings.iPoolBudgetKB = state
		GameOptions.SetInt('World/Streaming/PersistencyCache', 'PoolBudgetKB', state)
    end)

--Resouce
    nativeSettings.addRangeInt("/CORPORAT/ResourceLoaderThrottler", "Flood Min Non-Loading Threads", "This controls the minimum number of threads the game keeps free so it can handle other tasks while streaming/loading resources.(Default: 2)", 0, 8, 1, curSettings.iFloodMinNonLoadingThreads, defaultSettings.iFloodMinNonLoadingThreads, function(state)
        curSettings.iFloodMinNonLoadingThreads = state
		GameOptions.SetInt('ResourceLoaderThrottler', 'FloodMinNonLoadingThreads', state)
    end)

    nativeSettings.addRangeInt("/CORPORAT/ResourceLoaderThrottler", "Stream Max-Loading Threads", "Determines the maximum number of threads used for streaming resources (textures, models, sounds, etc.) in real-time (Default: 2)*3", 0, 8, 1, curSettings.iStreamMaxLoadingThreads, defaultSettings.iStreamMaxLoadingThreads, function(state)
        curSettings.iStreamMaxLoadingThreads = state
		GameOptions.SetInt('ResourceLoaderThrottler', 'StreamMaxLoadingThreads', state)
    end)

    nativeSettings.addRangeInt("/CORPORAT/ResourceLoaderThrottler", "Trickle Max-Loading Threads", "Limits how many CPU threads can simultaneously load resources during this mode. (Default: 1)*2", 0, 8, 1, curSettings.iTrickleMaxLoadingThreads, defaultSettings.iTrickleMaxLoadingThreads, function(state)
        curSettings.iTrickleMaxLoadingThreads = state
		GameOptions.SetInt('ResourceLoaderThrottler', 'TrickleMaxLoadingThreads', state)
    end)

--Streaming
    nativeSettings.addRangeInt("/CORPORAT/Streaming", "Max Nodes Per Frame", "Controls the maximum number of 'nodes' the streaming system can process per frame (Default: 300)*500", 300, 700, 25, curSettings.iMaxNodesPerFrame, defaultSettings.iMaxNodesPerFrame, function(state)
        curSettings.iMaxNodesPerFrame = state
		GameOptions.SetInt('Streaming', 'MaxNodesPerFrame', state)
    end)

    nativeSettings.addRangeInt("/CORPORAT/Streaming", "Editor Throttled Max Nodes Per Frame", "During normal gameplay it often has little effect unless streaming is the bottleneck. (Default: 500)", 500, 700, 25, curSettings.iEditorThrottledMaxNodesPerFrame, defaultSettings.iEditorThrottledMaxNodesPerFrame, function(state)
        curSettings.iEditorThrottledMaxNodesPerFrame = state
		GameOptions.SetInt('Streaming', 'EditorThrottledMaxNodesPerFrame', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/Streaming", "Time Limit Sector Load Per Frame", "It sets a maximum time budget per frame that the engine is allowed to spend loading world sectors. (Default: 2.0)*2.5", 1, 3, .25, "%.2f", curSettings.fTimeLimitSectorLoadPerFrame, defaultSettings.fTimeLimitSectorLoadPerFrame, function(state)
        curSettings.fTimeLimitSectorLoadPerFrame = state
		GameOptions.SetFloat('Streaming', 'TimeLimitSectorLoadPerFrame', state)
	end)

    nativeSettings.addRangeFloat("/CORPORAT/Streaming", "Time Limit Sector Unload Per Frame", "It defines the maximum time budget per frame that the engine may spend unloading world sectors (removing streamed-out geometry, collisions, entities, etc.). (Default: 1.0)*2.5", 1, 3, .25, "%.2f", curSettings.fTimeLimitSectorUnloadPerFrame, defaultSettings.fTimeLimitSectorUnloadPerFrame, function(state)
        curSettings.fTimeLimitSectorUnloadPerFrame = state
		GameOptions.SetFloat('Streaming', 'TimeLimitSectorUnloadPerFrame', state)
	end)

    nativeSettings.addRangeFloat("/CORPORAT/Streaming", "Time Limit Streamed Per Frame", "It caps the total amount of time per frame that the engine may spend on all streaming-related work combined, not just sector load or unload. (Default: 6.0)*3.0", 1, 6, .25, "%.2f", curSettings.fTimeLimitStreamedPerFrame, defaultSettings.fTimeLimitStreamedPerFrame, function(state)
        curSettings.fTimeLimitStreamedPerFrame = state
		GameOptions.SetFloat('Streaming', 'TimeLimitStreamedPerFrame', state)
	end)

    nativeSettings.addRangeFloat("/CORPORAT/Streaming", "Radius Near Secondary Ref Point Addend", "It adds extra distance to the near streaming radius around a secondary streaming reference point, causing sectors near that point to be kept loaded earlier and longer. (Default: 200)*500", 1, 500, 1, "%.1f", curSettings.fRadiusNearSecondaryRefPointAddend, defaultSettings.fRadiusNearSecondaryRefPointAddend, function(state)
        curSettings.fRadiusNearSecondaryRefPointAddend = state
		GameOptions.SetFloat('Streaming', 'RadiusNearSecondaryRefPointAddend', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/Streaming", "Auto Hide Distance Near", "Automatically hides objects that are very close to the camera under certain conditions (Default: 'On')", curSettings.bStreamingCullingAutoHideDistanceNearEnabled, defaultSettings.bStreamingCullingAutoHideDistanceNearEnabled, function(state)
		curSettings.bStreamingCullingAutoHideDistanceNearEnabled = state
		GameOptions.SetBool('Streaming/Culling/AutoHideDistanceNear', 'Enabled', state)
	end)

--Streaming/Culling
    nativeSettings.addSwitch("/CORPORAT/StreamingCulling", "Strict", "The engine may cull objects more aggressively, even at closer distances or lower importance (Default: 'Off')", curSettings.bStrict, defaultSettings.bStrict, function(state)
		curSettings.bStrict = state
		GameOptions.SetBool('Streaming/Culling', 'Strict', state)
	end)

--SHARC
    nativeSettings.addSwitch("/CORPORAT/SHARC", "Enable SHaRC", "Enables or disables Spatially Hashed Radiance Cache (SHaRC) (Default: 'On')", curSettings.bSHARC_Enable, defaultSettings.bSHARC_Enable, function(state)
		curSettings.bSHARC_Enable = state
		GameOptions.SetBool('Editor/SHARC', 'Enable', state)
	end)

    nativeSettings.addRangeFloat("/CORPORAT/SHARC", "Scene Scale", "Adjust the SHaRC voxel data size, a buffer with 128-bit entries which stores accumulated radiance and sample count. Two instances are used to store current and previous frame data (Default: 50)*100", 30, 300, 5, "%.0f", curSettings.fSHARC_SceneScale, defaultSettings.fSHARC_SceneScale, function(state)
        curSettings.fSHARC_SceneScale = state
		GameOptions.SetFloat('Editor/SHARC', 'SceneScale', state)
	end)

    nativeSettings.addRangeInt("/CORPORAT/SHARC", "Number of SHaRC bounces", "Adjust the Number of Light Bounces used by SHaRC (Default: 4)", 2, 5, 1, curSettings.iSHARC_Bounces, defaultSettings.iSHARC_Bounces, function(state)
        curSettings.iSHARC_Bounces = state
		GameOptions.SetInt('Editor/SHARC', 'Bounces', state)
    end)

    nativeSettings.addSwitch("/CORPORAT/SHARC", "SHaRC Use DI at Primary", "Determines whether RTXDI lighting is applied at the primary ray intersection (first surface hit). Primary rays are the first rays cast from the camera; using RTXDI here affects the initial lighting evaluation for surfaces. (Default: 'Off')*", curSettings.bUseRTXDIAtPrimary, defaultSettings.bUseRTXDIAtPrimary, function(state)
		curSettings.bUseRTXDIAtPrimary = state
		GameOptions.SetBool('Editor/SHARC', 'UseRTXDIAtPrimary', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/SHARC", "SHaRC Use DI with Albedo", "Determines whether RTXDI accounts for surface albedo (base color) when calculating lighting. Using albedo ensures the indirect lighting interacts correctly with surface colors, producing more realistic results. (Default: 'On')", curSettings.bUseRTXDIWithAlbedo, defaultSettings.bUseRTXDIWithAlbedo, function(state)
		curSettings.bUseRTXDIWithAlbedo = state
		GameOptions.SetBool('Editor/SHARC', 'UseRTXDIWithAlbedo', state)
	end)

    nativeSettings.addRangeFloat("/CORPORAT/SHARC", "Previous Frame Bias Allowance", "It determines how much trust or bias the current SHARC frame gives to the previous frame’s lighting data, affecting temporal stability and ghosting. (Default: 0.25)*1.0", 0, 1, .01, "%.2f", curSettings.fUsePrevFrameBiasAllowance, defaultSettings.fUsePrevFrameBiasAllowance, function(state)
        curSettings.fUsePrevFrameBiasAllowance = state
		GameOptions.SetFloat('Editor/SHARC', 'UsePrevFrameBiasAllowance', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/SHARC", "Use Previous Frame", "Controls whether SHARC reuses temporal data from the previous frame for faster and smoother ray-traced results. (Default: 'On')*", curSettings.bUsePrevFrame, defaultSettings.bUsePrevFrame, function(state)
		curSettings.bUsePrevFrame = state
		GameOptions.SetBool('Editor/SHARC', 'UsePrevFrame', state)
	end)

    nativeSettings.addRangeInt("/CORPORAT/SHARC", "History Reset", "This parameter instructs SHARC how often to clear or reinitialize its temporal history buffers. (Default: 15)*1", 0, 15, 1, curSettings.iHistoryReset, defaultSettings.iHistoryReset, function(state)
        curSettings.iHistoryReset = state
		GameOptions.SetInt('Editor/SHARC', 'HistoryReset', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/SHARC", "Clear", "This is effectively a manual cache invalidation trigger. (Default: 'Off')*", curSettings.bClear, defaultSettings.bClear, function(state)
		curSettings.bClear = state
		GameOptions.SetBool('Editor/SHARC', 'Clear', state)
	end)

    nativeSettings.addRangeInt("/CORPORAT/SHARC", "Down Scale Factor", "determines how much the SHARC cache is rendered at a lower resolution (Default: 5)", 1, 8, 1, curSettings.iSHARC_DownscaleFactor, defaultSettings.iSHARC_DownscaleFactor, function(state)
        curSettings.iSHARC_DownscaleFactor = state
		GameOptions.SetInt('Editor/SHARC', 'DownscaleFactor', state)
    end)

--Rendering/LUT
    nativeSettings.addRangeInt("/CORPORAT/LUT", "LUT Size in Cubic", "Adjust the LUT size for more accurate color grading (Default: 48)*64", 48, 64, 16, curSettings.iLUTSize, defaultSettings.iLUTSize, function(state)
        curSettings.iLUTSize = state
		GameOptions.SetInt('Rendering/LUT', 'Size', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/LUT", "LUT Max Range", "Defines how bright highlights are interpreted and displayed (Default: 100)", 10, 100, 1, "%.0f", curSettings.fLUTMaxRange, defaultSettings.fLUTMaxRange, function(state)
        curSettings.fLUTMaxRange = state
		GameOptions.SetFloat('Rendering/LUT', 'MaxRange', curSettings.fLUTMaxRange)
    end)

	nativeSettings.addSelectorString("/CORPORAT/LUT", "LUT Min Range", "Expand bottom of histogram to avoid crushing black floor (Default: 0.001)*0.000000000001", LUTlist, curSettings.iLUTMinRange_Index, defaultSettings.iLUTMinRange_Index, function(value)
		curSettings.fLUTMinRange = LUTlist[value]
		curSettings.iLUTMinRange_Index = value
		GameOptions.SetFloat('Rendering/LUT', "MinRange", tonumber(LUTlist[value]))
	end)
 
--RayTracing
    nativeSettings.addSwitch("/CORPORAT/RayTracing", "Raytraced Shadow Cascades", "Attempts to get around quality issues associated with traditional shadow mapping by splitting the camera frustum into multiple 'cascades' (Default 'Off')", curSettings.bEnableShadowCascades, defaultSettings.bEnableShadowCascades, function(state)
		curSettings.bEnableShadowCascades = state
		GameOptions.SetBool('RayTracing', 'EnableShadowCascades', state)
	end)

    nativeSettings.addRangeFloat("/CORPORAT/RayTracing", "Culling Distance Character", "Distance at wich NPC are removed (Default: 15) Above 15 can cause NPC to explode in large crowds when using population mods", 15, 75, 1, "%.0f", curSettings.fCullingDistanceCharacter, defaultSettings.fCullingDistanceCharacter, function(state)
		curSettings.fCullingDistanceCharacter = state
		GameOptions.SetFloat('RayTracing', 'CullingDistanceCharacter', state)
	end)

    nativeSettings.addRangeFloat("/CORPORAT/RayTracing", "Culling Distance Vehicle", "Distance at wich Vehicles are removed, above default vehicles will spawn on top of eacher other when using population increasing mods (Default: 40)", 40, 75, 1, "%.0f", curSettings.fCullingDistanceVehicle, defaultSettings.fCullingDistanceVehicle, function(state)
		curSettings.fCullingDistanceVehicle = state
		GameOptions.SetFloat('RayTracing', 'CullingDistanceVehicle', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/RayTracing", "Enable Shadow Optimizations", "When enabled the game applies optimizations to how RT shadows are computed and rendered — this can reduce performance cost with little visible difference. When disabled shadows may be slightly more accurate but at a higher GPU cost. (Default: 'On')", curSettings.bEnableShadowOptimizations, defaultSettings.bEnableShadowOptimizations, function(state)
		curSettings.bEnableShadowOptimizations = state
		GameOptions.SetBool('RayTracing', 'EnableShadowOptimizations', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/RayTracing", "Enable Raytraced Global Shadow", "Determines whether global shadows are computed using ray tracing (Default: 'On')", curSettings.bEnableGlobalShadow, defaultSettings.bEnableGlobalShadow, function(state)
		curSettings.bEnableGlobalShadow = state
		GameOptions.SetBool('RayTracing', 'EnableGlobalShadow', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/RayTracing", "Enable Local Raytraced Shadow", "Determines whether local shadows are computed using ray tracing (Default: 'On')", curSettings.bEnableLocalShadow, defaultSettings.bEnableLocalShadow, function(state)
		curSettings.bEnableLocalShadow = state
		GameOptions.SetBool('RayTracing', 'EnableLocalShadow', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/RayTracing", "Enable Importance Sampling", "This approach reduces noise and speeds up rendering by focusing on the most meaningful samples (Default: 'On')", curSettings.bEnableImportanceSampling, defaultSettings.bEnableImportanceSampling, function(state)
		curSettings.bEnableImportanceSampling = state
		GameOptions.SetBool('RayTracing', 'EnableImportanceSampling', state)
	end)

    nativeSettings.addRangeFloat("/CORPORAT/RayTracing", "Ray Tracing Radius", "Determines the maximum distance rays will travel to calculate lighting, shadows, or reflections. (Default: 200)", 100, 400, 1, "%.0f", curSettings.fTracingRadius, defaultSettings.fTracingRadius, function(state)
        curSettings.fTracingRadius = state
		GameOptions.SetFloat('RayTracing', 'TracingRadius', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/RayTracing", "Ray Tracing Radius for Reflections", "This command specifically adjusts the ray-tracing distance used for reflections, which affects how far reflective surfaces 'see' the scene (Default: 2000)", 800, 4000, 1, "%.0f", curSettings.fTracingRadiusReflections, defaultSettings.fTracingRadiusReflections, function(state)
        curSettings.fTracingRadiusReflections = state
		GameOptions.SetFloat('RayTracing', 'TracingRadiusReflections', state)
    end)

    nativeSettings.addSwitch("/CORPORAT/RayTracing", "Enable Ambient Occlusion", "This command toggles ray-traced ambient occlusion (AO), which adds realistic shading in corners and crevices (Default: 'On')*", curSettings.bEnableAmbientOcclusion, defaultSettings.bEnableAmbientOcclusion, function(state)
		curSettings.bEnableAmbientOcclusion = state
		GameOptions.SetBool('RayTracing', 'EnableAmbientOcclusion', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/RayTracing", "Enable Transparent Reflection", "This command toggles ray-traced reflections on transparent surfaces (like glass or water) (Default: 'On')", curSettings.bEnableTransparentReflection, defaultSettings.bEnableTransparentReflection, function(state)
		curSettings.bEnableTransparentReflection = state
		GameOptions.SetBool('RayTracing', 'EnableTransparentReflection', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/RayTracing", "Enable Diffuse Illumination", "This command toggles ray-traced diffuse illumination, which adds realistic indirect lighting to a scene (Default: 'On')", curSettings.bEnableDiffuseIllumination, defaultSettings.bEnableDiffuseIllumination, function(state)
		curSettings.bEnableDiffuseIllumination = state
		GameOptions.SetBool('RayTracing', 'EnableDiffuseIllumination', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/RayTracing", "Force Shadow LOD Bias Usage", "This command controls whether the engine enforces LOD bias for ray-traced shadows, affecting shadow detail at different distances (Default: 'On')*", curSettings.bForceShadowLODBiasUsage, defaultSettings.bForceShadowLODBiasUsage, function(state)
		curSettings.bForceShadowLODBiasUsage = state
		GameOptions.SetBool('RayTracing', 'ForceShadowLODBiasUsage', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/RayTracing", "Enable Reflection", "This command toggles ray-traced reflections in general, affecting reflective surfaces like mirrors, water, and shiny objects (Default: 'On')", curSettings.bEnableReflection, defaultSettings.bEnableReflection, function(state)
		curSettings.bEnableReflection = state
		GameOptions.SetBool('RayTracing', 'EnableReflection', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/RayTracing", "Enable Global Illumination", "This command toggles ray-traced global illumination (GI), which calculates realistic indirect lighting throughout the scene (Default: 'Off')", curSettings.bEnableGlobalIllumination, defaultSettings.bEnableGlobalIllumination, function(state)
		curSettings.bEnableGlobalIllumination = state
		GameOptions.SetBool('RayTracing', 'EnableGlobalIllumination', state)
	end)

	nativeSettings.addRangeInt("/CORPORAT/RayTracing", "Acceleration Structure Build Num Max", "This ensures frame time stability, but delays updates for some objects’ ray-traced representations. (Default: 64)*128", 64, 256, 32, curSettings.iAccelerationStructureBuildNumMax, defaultSettings.iAccelerationStructureBuildNumMax, function(state)
		curSettings.iAccelerationStructureBuildNumMax = state
		GameOptions.SetInt('RayTracing', 'AccelerationStructureBuildNumMax', state)
	end)

	nativeSettings.addRangeInt("/CORPORAT/RayTracing", "Scratch Buffer Size", "Scratch buffer is temporary GPU memory required to perform computations when building or refitting acceleration structures. (Default: 32)*64", 32, 128, 16, curSettings.iScratchBufferSizeMB, defaultSettings.iScratchBufferSizeMB, function(state)
		curSettings.iScratchBufferSizeMB = state
		GameOptions.SetInt('RayTracing', 'ScratchBufferSizeMB', state)
	end)

	nativeSettings.addRangeInt("/CORPORAT/RayTracing", "Geometry Update Buffer Size", "This buffer acts as a staging area for dynamic geometry that changes from frame to frame. (Default: 64)*128", 64, 256, 16, curSettings.iGeometryUpdateBufferSizeMB, defaultSettings.iGeometryUpdateBufferSizeMB, function(state)
		curSettings.iGeometryUpdateBufferSizeMB = state
		GameOptions.SetInt('RayTracing', 'GeometryUpdateBufferSizeMB', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/RayTracing", "Enable NRD", "Controls whether NRD (NVIDIA Real-Time Denoiser) is enabled for ray-traced rendering. (Default: 'On')*", curSettings.bEnableNRD, defaultSettings.bEnableNRD, function(state)
		curSettings.bEnableNRD = state
		GameOptions.SetBool('RayTracing', 'EnableNRD', state)
	end)

	nativeSettings.addRangeInt("/CORPORAT/RayTracing", "Material Proxy Num Max", "That one controls how many ray-tracing material proxies the engine is allowed to keep alive at once. (Default: 32)*48", 32, 64, 16, curSettings.iMaterialProxyNumMax, defaultSettings.iMaterialProxyNumMax, function(state)
		curSettings.iMaterialProxyNumMax = state
		GameOptions.SetInt('RayTracing', 'MaterialProxyNumMax', state)
	end)

	nativeSettings.addRangeInt("/CORPORAT/RayTracing", "Material Proxy Update Num Max", "The maximum number of RT material proxies that can be created or updated in a single frame. (Default: 65536)*131072", 65536, 262144, 65536, curSettings.iMaterialProxyUpdateNumMax, defaultSettings.iMaterialProxyUpdateNumMax, function(state)
		curSettings.iMaterialProxyUpdateNumMax = state
		GameOptions.SetInt('RayTracing', 'MaterialProxyUpdateNumMax', state)
	end)

--RayTracing/Reflection
    nativeSettings.addSwitch("/CORPORAT/Reflection", "Reflection Adaptive Sampling", "This command toggles adaptive sampling for ray-traced reflections, which helps optimize performance by varying the number of rays traced based on scene complexity (Default: 'On')*", curSettings.bReflectionAdaptiveSampling, defaultSettings.bReflectionAdaptiveSampling, function(state)
		curSettings.bReflectionAdaptiveSampling = state
		GameOptions.SetBool('RayTracing/Reflection', 'AdaptiveSampling', state)
	end)

--RayTracing/Diffuse
    nativeSettings.addSwitch("/CORPORAT/Diffuse", "Diffuse Adaptive Sampling", "Dynamically adjusts ray counts per scene area to optimize performance while keeping reflections high quality (Default: 'On')*", curSettings.bDiffuseAdaptiveSampling, defaultSettings.bDiffuseAdaptiveSampling, function(state)
		curSettings.bDiffuseAdaptiveSampling = state
		GameOptions.SetBool('RayTracing/Reflection', 'AdaptiveSampling', state)
	end)

--Rendering/Shadows
    nativeSettings.addSwitch("/CORPORAT/Shadows", "Enable Cascades Heuristic Force Refresh", "Forces the engine to refresh shadow cascades more aggressively based on movement or changes in the scene (Default: 'Off')*", curSettings.bCascadesHeuristicForceRefresh, defaultSettings.bCascadesHeuristicForceRefresh, function(state)
		curSettings.bCascadesHeuristicForceRefresh = state
		GameOptions.SetBool('Rendering/Shadows', 'CascadesHeuristicForceRefresh', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/Shadows", "Force Distant Foliage Shadows", "'On' leaves, grass, and small vegetation are included in distant shadow calculations. (Default: 'Off')", curSettings.bDistantShadowsForceFoliageGeometry, defaultSettings.bCascadesHeuristicForceRefresh, function(state)
		curSettings.bDistantShadowsForceFoliageGeometry = state
		GameOptions.SetBool('Rendering/Shadows', 'DistantShadowsForceFoliageGeometry', state)
	end)

--Rendering
    nativeSettings.addSwitch("/CORPORAT/Rendering", "Allow RayTraced Reference Rejitter", "Pass pre-denoise jtter information to the temporal upscaler. This workaround preserves detail when a PT denoiser removes jitter (Default: 'Off')", curSettings.bAllowRayTracedReferenceRejitter, defaultSettings.bAllowRayTracedReferenceRejitter, function(state)
		curSettings.bAllowRayTracedReferenceRejitter = state
		GameOptions.SetBool('Rendering', 'AllowRayTracedReferenceRejitter', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/Rendering", "Allow RTXDI Rejitter", "Allowing rejitter means the engine is permitted to periodically reshuffle (re-jitter) the light sample sequence, improving temporal stability and reducing long-term bias. (Default: 'Off')", curSettings.bAllowRTXDIRejitter, defaultSettings.bAllowRTXDIRejitter, function(state)
		curSettings.bAllowRTXDIRejitter = state
		GameOptions.SetBool('Rendering', 'AllowRTXDIRejitter', state)
	end)

    nativeSettings.addRangeFloat("/CORPORAT/Rendering", "Bloom Luminance Clamp Factor", "Luminance Clamp Factor is a multiplier that limits (clamps) how much luminance (brightness) gets pushed into the bloom pass. (Default: 0.07)", 0.0, 2.0, 0.01, "%.2f", curSettings.fBloomLuminanceClampFactor, defaultSettings.fBloomLuminanceClampFactor, function(state)
        curSettings.fBloomLuminanceClampFactor = state
		GameOptions.SetFloat('Rendering', 'BloomLuminanceClampFactor', state)
    end)

    nativeSettings.addSwitch("/CORPORAT/Rendering", "Distant Global Illumination Fix", "Usually corrects lighting artifacts in faraway city geometry when DistantGI is active (Default: 'On')", curSettings.bDistantGiFix, defaultSettings.bDistantGiFix, function(state)
		curSettings.bDistantGiFix = state
		GameOptions.SetBool('Rendering', 'DistantGiFix', state)
	end)
	 
    nativeSettings.addSwitch("/CORPORAT/Rendering", "Garments Use Smoothing", "Controls whether cloth/garment simulation uses smoothing (stabilization) passes on character clothing (Default: 'On')", curSettings.bGarmentUseSmoothing, defaultSettings.bGarmentUseSmoothing, function(state)
		curSettings.bGarmentUseSmoothing = state
		GameOptions.SetBool('Rendering', 'GarmentUseSmoothing', state)
	end)
	 
    nativeSettings.addSwitch("/CORPORAT/Rendering", "Use Experimental Volumetric Fog", "This controls whether the game uses the experimental volumetric fog renderer that CDPR left in the engine. (Default: 'On')", curSettings.bUseExperimentalVolFog, defaultSettings.bUseExperimentalVolFog, function(state)
		curSettings.bUseExperimentalVolFog = state
		GameOptions.SetBool('Rendering', 'UseExperimentalVolFog', state)
	end)

	nativeSettings.addRangeInt("/CORPORAT/Rendering", "Max G-Buffer Splits", "Opaque geometry can be split across multiple G-Buffer layers to correctly render overlapping surfaces, decals, and alpha-tested geometry without artifacts. (Default: 8)", 8, 32, 8, curSettings.iMaxGbufferSplits, defaultSettings.iMaxGbufferSplits, function(state)
		curSettings.iMaxGbufferSplits = state
		GameOptions.SetInt('Rendering', 'MaxGbufferSplits', state)
	end)

	nativeSettings.addRangeFloat("/CORPORAT/Rendering", "Volumetric Fog Volume Default Absorption", "Controls how much light gets removed as it travels through the fog volume. (Default: 1)", 0, 1, 0.01, "%.2f", curSettings.fVolumetricFogVolume_DefaultAbsorption, defaultSettings.fVolumetricFogVolume_DefaultAbsorption, function(state)
		curSettings.fVolumetricFogVolume_DefaultAbsorption = state
		GameOptions.SetInt('Rendering', 'VolumetricFogVolume_DefaultAbsorption', state)
	end)

--Developer/FeatureToggles
    nativeSettings.addSwitch("/CORPORAT/FeatureToggles", "Enable RTXDI", "Enable RTXDI (Real-Time Direct Illumination) (PT Default: 'On')", curSettings.bRTXDI, defaultSettings.bRTXDI, function(state)
		curSettings.bRTXDI = state
		GameOptions.SetBool('Developer/FeatureToggles', 'RTXDI', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/FeatureToggles", "Volumetric Fog", "Enable Volumetric Fog (Default: 'On')", curSettings.bVolumetricFog, defaultSettings.bVolumetricFog, function(state)
		curSettings.bVolumetricFog = state
		GameOptions.SetBool('Developer/FeatureToggles', 'VolumetricFog', state)
	end)
	
    nativeSettings.addSwitch("/CORPORAT/FeatureToggles", "Enable Character Rim Enhancement", "Artificial lighting on on edges of characters clothes and skin and other world items (Default: 'On')*", curSettings.bCharacterRimEnhancement, defaultSettings.bCharacterRimEnhancement, function(state)
		curSettings.bCharacterRimEnhancement = state
		GameOptions.SetBool('Developer/FeatureToggles', 'CharacterRimEnhancement', state)
	end)
	
    nativeSettings.addSwitch("/CORPORAT/FeatureToggles", "Enable Constrast Adaptive Sharpening", "Technique used to improve image sharpness by intelligently adjusting the amount of sharpening based on the local contrast of the image (Default: 'On')*", curSettings.bConstrastAdaptiveSharpening, defaultSettings.bConstrastAdaptiveSharpening, function(state)
		curSettings.bConstrastAdaptiveSharpening = state
		GameOptions.SetBool('Developer/FeatureToggles', 'ConstrastAdaptiveSharpening', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/FeatureToggles", "Contact Shadows", "The goal of using Contact Shadows is to capture small details that regular shadow mapping algorithms fail to capture (Default: 'On')", curSettings.bContactShadows, defaultSettings.bContactShadows, function(state)
		curSettings.bContactShadows = state
		GameOptions.SetBool('Developer/FeatureToggles', 'ContactShadows', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/FeatureToggles", "Screen Space Underwater", "Enable Screen Space Underwater (Default: 'On')", curSettings.bScreenSpaceUnderwater, defaultSettings.bScreenSpaceUnderwater, function(state)
		curSettings.bScreenSpaceUnderwater = state
		GameOptions.SetBool('Developer/FeatureToggles', 'ScreenSpaceUnderwater', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/FeatureToggles", "Bloom", "Bloom simulates light bleeding beyond the edges of very bright objects, creating a glow. (Default: 'On')", curSettings.bBloom, defaultSettings.bBloom, function(state)
		curSettings.bBloom = state
		GameOptions.SetBool('Developer/FeatureToggles', 'Bloom', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/FeatureToggles", "Screen Space Heat Haze", "Enable Heat Haze Effects (Default: 'On')", curSettings.bScreenSpaceHeatHaze, defaultSettings.bScreenSpaceHeatHaze, function(state)
		curSettings.bScreenSpaceHeatHaze = state
		GameOptions.SetBool('Developer/FeatureToggles', 'ScreenSpaceHeatHaze', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/FeatureToggles", "Screen Space Reflections", "The regular reflections everyone sees in-game. Fast, approximate, and limited by what’s on-screen (objects not currently visible can’t be reflected). (Default: 'On')*", curSettings.bScreenSpaceReflection, defaultSettings.bScreenSpaceReflection, function(state)
		curSettings.bScreenSpaceReflection = state
		GameOptions.SetBool('Developer/FeatureToggles', 'ScreenSpaceReflection', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/FeatureToggles", "Screen Space Planar Reflections", "The flag being toggled. This controls planar reflections rendered in screen space, a higher-fidelity reflection technique compared to SSR (Screen Space Reflections). It can provide more accurate reflections (especially for water and glossy flat surfaces), but it’s expensive performance-wise. (Default: 'On')*", curSettings.bScreenSpacePlanarReflection, defaultSettings.bScreenSpacePlanarReflection, function(state)
		curSettings.bScreenSpacePlanarReflection = state
		GameOptions.SetBool('Developer/FeatureToggles', 'ScreenSpacePlanarReflection', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/FeatureToggles", "Enable Global Illumination (Raster)", "It controls a specific RTGI pass for far-distance scenery, e.g. lighting of large cityscapes or faraway terrain that isn’t covered by the regular local RTGI volumes. (Default: 'On')", curSettings.bDistantGI, defaultSettings.bDistantGI, function(state)
		curSettings.bDistantGI = state
		GameOptions.SetBool('Developer/FeatureToggles', 'DistantGI', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/FeatureToggles", "Character Subsurface Scattering", "Subsurface scattering simulates light penetrating slightly into skin (or other translucent materials), scattering, and exiting elsewhere. (Default: 'On')", curSettings.bCharacterSubsurfaceScattering, defaultSettings.bCharacterSubsurfaceScattering, function(state)
		curSettings.bCharacterSubsurfaceScattering = state
		GameOptions.SetBool('Developer/FeatureToggles', 'CharacterSubsurfaceScattering', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/FeatureToggles", "Character Subsurface Translucency", "While Subsurface Scattering handles general light diffusion within skin, Subsurface Translucency controls light transmission through thin parts of character materials. (Default: 'Off')", curSettings.bCharacterSubsurfaceTranslucency, defaultSettings.bCharacterSubsurfaceTranslucency, function(state)
		curSettings.bCharacterSubsurfaceTranslucency = state
		GameOptions.SetBool('Developer/FeatureToggles', 'CharacterSubsurfaceTranslucency', state)
	end)

--Audio
    nativeSettings.addSwitch("/CORPORAT/Audio", "Enable Breathing System", "Enables or disables V's breathing Sound (Default: 'Off')", curSettings.bBreathingSystem, defaultSettings.bBreathingSystem, function(state)
		curSettings.bBreathingSystem = state
		GameOptions.SetBool('Editor/Audio/Features', 'BreathingSystem', state)
		TweakDB:SetFlat('BaseStatusEffect.PlayerExhausted_inline2.effectors', {"BaseStatusEffect.PlayerExhausted_inline3", "BaseStatusEffect.PlayerExhausted_inline7", "BaseStatusEffect.BreathingHeavy_inline1"})
	end)
	
--DLSS	
	nativeSettings.addRangeInt("/CORPORAT/DLSS", "Number of DLSS Samples", "Determines how many temporal samples per frame DLSS uses for reconstruction. (Default: 16)", 16, 32, 16, curSettings.iDLSS_SampleNumber, defaultSettings.iDLSS_SampleNumber, function(state)
		curSettings.iDLSS_SampleNumber = state
		GameOptions.SetInt('DLSS', 'SampleNumber', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/DLSS", "Enable Halton", "A rendering option that toggles the use of a Halton low-discrepancy sequence for sample generation instead of purely random or simpler jitter patterns. (Default: 'Off')*", curSettings.bEnableHalton, defaultSettings.bEnableHalton, function(state)
		curSettings.bEnableHalton = state
		GameOptions.SetBool('DLSS', 'EnableHalton', state)
	end)

--Editor/RTXDI
	nativeSettings.addSwitch("/CORPORAT/RTXDI", "Enable Approximate Probability Density Functions", "Enabling this makes the renderer use an approximate PDF (Probability Density Functions) to choose which lights to sample (Default: 'Off')*", curSettings.bEnableApproximateTargetPDF, defaultSettings.bEnableApproximateTargetPDF, function(state)
		curSettings.bEnableApproximateTargetPDF = state
		GameOptions.SetBool('Editor/RTXDI', 'EnableApproximateTargetPDF', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/RTXDI", "Enable Local Light Importance Sampling", "Importance sampling focuses computational effort on lights that contribute most to the scene, improving efficiency (Default: 'Off')", curSettings.bEnableLocalLightImportanceSampling, defaultSettings.bEnableLocalLightImportanceSampling, function(state)
		curSettings.bEnableLocalLightImportanceSampling = state
		GameOptions.SetBool('Editor/RTXDI', 'EnableLocalLightImportanceSampling', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/RTXDI", "Enable Fallback Light", "When enabled, the renderer provides a fallback light source if the RTXDI calculations fail or are insufficient. (Default 'On')", curSettings.bEnableFallbackLight, defaultSettings.bEnableFallbackLight, function(state)
		curSettings.bEnableFallbackLight = state
		GameOptions.SetBool('Editor/RTXDI', 'EnableFallbackLight', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/RTXDI", "Enable Separate Denoising", "Denoise Indirect/Direct lighting seperately, quality improvement and fixes foilage lighting (Default: 'On')", curSettings.bEnableSeparateDenoising, defaultSettings.bEnableSeparateDenoising, function(state)
		curSettings.bEnableSeparateDenoising = state
		GameOptions.SetBool('Editor/RTXDI', 'EnableSeparateDenoising', state)
	end)

    nativeSettings.addRangeFloat("/CORPORAT/RTXDI", "Shadow Fade Fraction", "Affects the smoothness of shadow transitions for RTXDI indirect lighting.(Default 0.10)", 0.01, 0.2, 0.01, "%.2f", curSettings.fShadowFadeFraction, defaultSettings.fShadowFadeFraction, function(state)
        curSettings.fShadowFadeFraction = state
		GameOptions.SetFloat('Editor/RTXDI', 'ShadowFadeFraction', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/RTXDI", "Forced Shadow Light Source Radius", "Uses the physical size of a light source when calculating shadow softness. Larger lights create softer penumbras, while smaller lights create sharper shadows. (Default 0.10)*0.05", 0.01, 0.2, 0.01, "%.2f", curSettings.fForcedShadowLightSourceRadius, defaultSettings.fForcedShadowLightSourceRadius, function(state)
        curSettings.fForcedShadowLightSourceRadius = state
		GameOptions.SetFloat('Editor/RTXDI', 'ForcedShadowLightSourceRadius', state)
    end)

	nativeSettings.addSwitch("/CORPORAT/RTXDI", "Enable Gradients", "Gradients help smooth lighting transitions and reduce artifacts or noise, improving visual fidelity in RTXDI previews (Default: 'Off')*", curSettings.bEnableGradients, defaultSettings.bEnableGradients, function(state)
		curSettings.bEnableGradients = state
		GameOptions.SetBool('Editor/RTXDI', 'EnableGradients', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/RTXDI", "Enable NRD Custom Denoiser", "NRD denoiser modification. Should be enabled with NRD. Reduces traversal noise at the with minor loss of edge detail (use sharpening) (Default: 'Off')", curSettings.bUseCustomDenoiser, defaultSettings.bUseCustomDenoiser, function(state)
		curSettings.bUseCustomDenoiser = state
		GameOptions.SetBool('Editor/RTXDI', 'UseCustomDenoiser', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/RTXDI", "Enable RTX DI Denoising", "Helps reduce noise in indirect lighting generated by RTXDI rays. (Default: 'On')*", curSettings.bEnableRTXDIDenoising, defaultSettings.bEnableRTXDIDenoising, function(state)
		curSettings.bEnableRTXDIDenoising = state
		GameOptions.SetBool('Editor/RTXDI', 'EnableRTXDIDenoising', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/RTXDI", "Initial Candidates in Temporal", "Controls whether initial light candidates for RTXDI sampling are reused temporally (across frames). (Default: 'Off')*", curSettings.bInitialCandidatesInTemporal, defaultSettings.bInitialCandidatesInTemporal, function(state)
		curSettings.bInitialCandidatesInTemporal = state
		GameOptions.SetBool('Editor/RTXDI', 'InitialCandidatesInTemporal', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/RTXDI", "Enable Environment Lights", "This option tells RTXDI whether to include environment lights (sky, IBL/Skydome, reflection probes, etc.) in its direct illumination calculations. (Default: 'Off')", curSettings.bEnableEnvironmentLights, defaultSettings.bEnableEnvironmentLights, function(state)
		curSettings.bEnableEnvironmentLights = state
		GameOptions.SetBool('Editor/RTXDI', 'EnableEnvironmentLights', state)
	end)

    nativeSettings.addSwitch("/CORPORAT/RTXDI", "Force All Shadows", "Force All Shadows makes every light source ignore their shadow casting properties", curSettings.bForceAllShadows, defaultSettings.bForceAllShadows, function(state)
        curSettings.bForceAllShadows = state
		GameOptions.SetBool('Editor/RTXDI', 'ForceAllShadows', state)
    end)

    nativeSettings.addSelectorString("/CORPORAT/RTXDI", "Bias Correction Mode", "This controls how RTXDI handles bias correction in lighting calculations. Bias correction is a technique to reduce light leaking or shadow artifacts. (Default: Basic)", bias_list, curSettings.iRTXDI_BiasCorrectionMode, defaultSettings.iRTXDI_BiasCorrectionMode, function(state)
        curSettings.iRTXDI_BiasCorrectionMode = tonumber(state)
 		GameOptions.SetInt('Editor/RTXDI', 'BiasCorrectionMode', (tonumber(state)-1))
   end)

    nativeSettings.addSelectorString("/CORPORAT/RTXDI", "Permutation Sampling Mode", "A permutation sampling mode typically decides how light samples are shuffled or stratified to reduce noise in ray tracing. (Default: Deterministic)", permutaion_list, curSettings.iRTXDI_PermutationSamplingMode, defaultSettings.iRTXDI_PermutationSamplingMode, function(state)
        curSettings.iRTXDI_PermutationSamplingMode = tonumber(state)
 		GameOptions.SetInt('Editor/RTXDI', 'PermutationSamplingMode', (tonumber(state)-1))
   end)
	
    nativeSettings.addRangeFloat("/CORPORAT/RTXDI", "Boiling Filter Strength", "RTXDI also relies on reservoir resampling over time, and suffers from the same “boiling” artifacts (rapid per-frame variance causing lights to shimmer or crawl). Typical range 0.3 - 0.6 above 0.60 can cause image to become blurry. (Default: 0.50)*0.25", 0.0, 1.0, 0.01, "%.2f", curSettings.fRTXDI_BoilingFilterStrength, defaultSettings.fRTXDI_BoilingFilterStrength, function(state)
        curSettings.fRTXDI_BoilingFilterStrength = state
		GameOptions.SetFloat('Editor/RTXDI', 'BoilingFilterStrength', state)
    end)

	nativeSettings.addRangeInt("/CORPORAT/RTXDI", "Max History Length", "History length refers to how many previous frames of sampled lighting information the system keeps and reuses. (Default: 20, Higher values can cause ghosting)*3", 0, 20, 1, curSettings.iRTXDI_MaxHistoryLength, defaultSettings.iRTXDI_MaxHistoryLength, function(state)
		curSettings.iRTXDI_MaxHistoryLength = state
		GameOptions.SetInt('Editor/RTXDI', 'MaxHistoryLength', state)
    end)

	nativeSettings.addRangeFloat("/CORPORAT/RTXDI", "Spatial Sampling Radius", "The spatial sampling radius determines how far RTXDI will search for those neighbors. (Default: 32)*24", 1, 32, 1, "%.0f", curSettings.fRTXDI_SpatialSamplingRadius, defaultSettings.fRTXDI_SpatialSamplingRadius, function(state)
		curSettings.fRTXDI_SpatialSamplingRadius = state
		GameOptions.SetFloat('Editor/RTXDI', 'SpatialSamplingRadius', state)
    end)

	nativeSettings.addRangeInt("/CORPORAT/RTXDI", "Spatial Num Disocclusion Boost Samples", "Sets how many extra neighbor samples RTXDI pulls in for those disoccluded pixels. (Default: 8)*12", 0, 24, 1, curSettings.iRTXDI_SpatialNumDisocclusionBoostSamples, defaultSettings.iRTXDI_SpatialNumDisocclusionBoostSamples, function(state)
		curSettings.iRTXDI_SpatialNumDisocclusionBoostSamples = state
		GameOptions.SetInt('Editor/RTXDI', 'SpatialNumDisocclusionBoostSamples', state)
    end)

	nativeSettings.addRangeInt("/CORPORAT/RTXDI", "Spatial Num Samples", "Sets the base number of neighbor samples RTXDI uses during spatial resampling. (Default: 1)*2", 0, 5, 1, curSettings.iRTXDI_SpatialNumSamples, defaultSettings.iRTXDI_SpatialNumSamples, function(state)
		curSettings.iRTXDI_SpatialNumSamples = state
		GameOptions.SetInt('Editor/RTXDI', 'SpatialNumSamples', state)
    end)

	nativeSettings.addRangeInt("/CORPORAT/RTXDI", "Num Initial Samples", "Sets how many new light samples RTXDI generates before any temporal or spatial reuse kicks in. (Default: 8)*16", 0, 24, 1, curSettings.iRTXDI_NumInitialSamples, defaultSettings.iRTXDI_NumInitialSamples, function(state)
		curSettings.iRTXDI_NumInitialSamples = state
		GameOptions.SetInt('Editor/RTXDI', 'NumInitialSamples', state)
    end)

	nativeSettings.addRangeInt("/CORPORAT/RTXDI", "Num Env Map Samples", "Controls how many environment map light samples RTXDI draws per pixel per frame. (Default: 8)", 0, 16, 1, curSettings.iRTXDI_NumEnvMapSamples, defaultSettings.iRTXDI_NumEnvMapSamples, function(state)
		curSettings.iRTXDI_NumEnvMapSamples = state
		GameOptions.SetInt('Editor/RTXDI', 'NumEnvMapSamples', state)
    end)

--RayTracing/Reference
	nativeSettings.addSwitch("/CORPORAT/Reference", "Enable Probabilistic Sampling", "Determines whether the renderer uses stochastic/probabilistic sampling instead of fixed or uniform ray sampling. Probabilistic sampling can reduce the number of rays needed for convergence while maintaining statistical accuracy. (Default: 'Off')", curSettings.bEnableProbabilisticSampling, defaultSettings.bEnableProbabilisticSampling, function(state)
		curSettings.bEnableProbabilisticSampling = state
		GameOptions.SetBool('RayTracing/Reference', 'EnableProbabilisticSampling', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/Reference", "Enable Ray-Traced Importance Sampling (RIS)", "Change how samples for RTGI or RT Reflections are chosen (potentially improving quality in dark or complex lighting). (Default: 'On')", curSettings.bEnableRIS, defaultSettings.bEnableRIS, function(state)
		curSettings.bEnableRIS = state
		GameOptions.SetBool('RayTracing/Reference', 'EnableRIS', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/Reference", "Enable Fixed", "'Off' Uses adaptive sampling (may vary per pixel for efficiency), 'On' enable fixed ray counts (deterministic). (Default: 'On')*", curSettings.bEnableFixed, defaultSettings.bEnableFixed, function(state)
		curSettings.bEnableFixed = state
		GameOptions.SetBool('RayTracing/Reference', 'EnableFixed', state)
	end)

--Editor/PathTracing
	nativeSettings.addSwitch("/CORPORAT/PathTracing", "Use Screen Space Data", "Determines whether screen-space information (like depth, normals, and material properties) is used to accelerate or refine path tracing. (Default 'Off')*", curSettings.bUseScreenSpaceData, defaultSettings.bUseScreenSpaceData, function(state)
		curSettings.bUseScreenSpaceData = state
		GameOptions.SetBool('Editor/PathTracing', 'UseScreenSpaceData', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/PathTracing", "Use SSR Fall back", "This toggles whether Screen Space Reflections (SSR) are used as a fallback when path-traced reflections are unavailable. (Default 'On')", curSettings.bUseSSRFallback, defaultSettings.bUseSSRFallback, function(state)
		curSettings.bUseSSRFallback = state
		GameOptions.SetBool('Editor/PathTracing', 'UseSSRFallback', state)
	end)

--Editor/ReSTIRGI
	nativeSettings.addSwitch("/CORPORAT/ReSTIRGI", "Enable ReSTIR GI", "Enable Reservoir-based Spatio-Temporal Importance Resampling Global Illunination, covers the bulk of indirect lighting paths when used with SHARC (Default 'On')", curSettings.bEnableReSTIRGI, defaultSettings.bEnableReSTIRGI, function(state)
		curSettings.bEnableReSTIRGI = state
		GameOptions.SetBool('Editor/ReSTIRGI', 'Enable', state)
	end)
 
	nativeSettings.addSwitch("/CORPORAT/ReSTIRGI", "Enable ReSTIR GI Fallback Sampling", "Ensures indirect lighting remains visible even when the algorithm cannot find good samples. (Default 'Off')*", curSettings.bEnableFallbackSampling, defaultSettings.bEnableFallbackSampling, function(state)
		curSettings.bEnableFallbackSampling = state
		GameOptions.SetBool('Editor/ReSTIRGI', 'EnableFallbackSampling', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/ReSTIRGI", "Enable ReSTIR GI Temporal Reuse", "When enabled, ReSTIRGI reuses candidate samples from previous frames to improve temporal stability and reduce noise. (Default 'Off')*", curSettings.bUseTemporalRGS, defaultSettings.bUseTemporalRGS, function(state)
		curSettings.bUseTemporalRGS = state
		GameOptions.SetBool('Editor/ReSTIRGI', 'UseTemporalRGS', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/ReSTIRGI", "Enable Boiling Filter", "Reduces the weight of oversampled reservoirs to reduce bias (Default 'Off')*", curSettings.bEnableBoilingFilter, defaultSettings.bEnableBoilingFilter, function(state)
		curSettings.bEnableBoilingFilter = state
		GameOptions.SetBool('Editor/ReSTIRGI', 'EnableBoilingFilter', state)
	end)

    nativeSettings.addRangeFloat("/CORPORAT/ReSTIRGI", "Boiling Filter Strength", "When ray traced GI reuses samples across frames, sometimes the result “shimmers” or “boils” because the reservoirs change too abruptly. Above 0.50 can cause image to become blurry. (Default: 0.40)*0.20", 0.0, 1.0, 0.01, "%.2f", curSettings.fReSTIRGI_BoilingFilterStrength, defaultSettings.fReSTIRGI_BoilingFilterStrength, function(state)
        curSettings.fReSTIRGI_BoilingFilterStrength = state
		GameOptions.SetFloat('Editor/ReSTIRGI', 'BoilingFilterStrength', state)
    end)

	nativeSettings.addSwitch("/CORPORAT/ReSTIRGI", "Enable Fused", "When enabled, ReSTIRGI fuses multiple sampling stages (e.g., spatial + temporal resampling) into a single pass. (Default 'On')", curSettings.bEnableFused, defaultSettings.bEnableFused, function(state)
		curSettings.bEnableFused = state
		GameOptions.SetBool('Editor/ReSTIRGI', 'EnableFused', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/ReSTIRGI", "Enable ReSTIR GI Spatial Reuse", "When enabled, ReSTIRGI reuses candidate samples from neighboring pixels (spatial resampling) to reduce noise and improve efficiency. (Default 'On')", curSettings.bUseSpatialRGS, defaultSettings.bUseSpatialRGS, function(state)
		curSettings.bUseSpatialRGS = state
		GameOptions.SetBool('Editor/ReSTIRGI', 'UseSpatialRGS', state)
	end)

    nativeSettings.addSelectorString("/CORPORAT/ReSTIRGI", "Bias Correction Mode", "Controls how bias correction is handled for ReSTIR GI’s resampling. Bias correction helps reduce over-bright lighting, fireflies, or light leaking artifacts caused by the resampling step. (Default: None)", bias_list, curSettings.iEditor_ReSTRIGI_BiasCorrectionMode, defaultSettings.iEditor_ReSTRIGI_BiasCorrectionMode, function(state)
        curSettings.iEditor_ReSTRIGI_BiasCorrectionMode = tonumber(state)
 		GameOptions.SetInt('Editor/ReSTIRGI', 'BiasCorrectionMode', (tonumber(state)-1))
   end)

    nativeSettings.addSelectorString("/CORPORAT/ReSTIRGI", "Permutation Sampling Mode", "Both RTXDI and ReSTIR GI use reservoir sampling with spatial + temporal reuse. To get good convergence without visible noise, they rely on permutation strategies (scrambling random numbers so you don’t get structured noise or banding). (Default: Deterministic)", permutaion_list, curSettings.iReSTIRGI_PermutationSamplingMode, defaultSettings.iReSTIRGI_PermutationSamplingMode, function(state)
        curSettings.iReSTIRGI_PermutationSamplingMode = tonumber(state)
 		GameOptions.SetInt('Editor/ReSTIRGI', 'PermutationSamplingMode', (tonumber(state)-1))
   end)

	nativeSettings.addRangeInt("/CORPORAT/ReSTIRGI", "Max History Length", "Defines how many previous frames of global illumination samples can be reused. (Default: 8)", 0, 8, 1, curSettings.iReSTIRGI_MaxHistoryLength, defaultSettings.iReSTIRGI_MaxHistoryLength, function(state)
        curSettings.iReSTIRGI_MaxHistoryLength = state
		GameOptions.SetInt('Editor/ReSTIRGI', 'MaxHistoryLength', state)
    end)

	nativeSettings.addRangeInt("/CORPORAT/ReSTIRGI", "Max Reservoir Age", "The maximum number of frames an individual reservoir is allowed to live before being discarded/refreshed. (Default: 32)*48", 0, 48, 1, curSettings.iReSTIRGI_MaxReservoirAge, defaultSettings.iReSTIRGI_MaxReservoirAge, function(state)
        curSettings.iReSTIRGI_MaxReservoirAge = state
		GameOptions.SetInt('Editor/ReSTIRGI', 'MaxReservoirAge', state)
    end)

	nativeSettings.addRangeFloat("/CORPORAT/ReSTIRGI", "Spatial Sampling Radius", "The spatial sampling radius determines how far RTXDI will search for those neighbors. (Default: 32)", 1, 32, 1, "%.0f", curSettings.fReSTIRGI_SpatialSamplingRadius, defaultSettings.fReSTIRGI_SpatialSamplingRadius, function(state)
		curSettings.fReSTIRGI_SpatialSamplingRadius = state
		GameOptions.SetFloat('Editor/ReSTIRGI', 'SpatialSamplingRadius', state)
    end)

	nativeSettings.addRangeInt("/CORPORAT/ReSTIRGI", "Spatial Num Disocclusion Boost Samples", "How many extra neighbor samples are pulled on top of the normal SpatialNumSamples when filling in disoccluded pixels. (Default: 2)*5", 0, 5, 1, curSettings.iReSTIRGI_SpatialNumDisocclusionBoostSamples, defaultSettings.iReSTIRGI_SpatialNumDisocclusionBoostSamples, function(state)
        curSettings.iReSTIRGI_SpatialNumDisocclusionBoostSamples = state
		GameOptions.SetInt('Editor/ReSTIRGI', 'SpatialNumDisocclusionBoostSamples', state)
    end)

	nativeSettings.addRangeInt("/CORPORAT/ReSTIRGI", "Spatial Num Samples", "How many nearby pixels to compare in order to improve the GI reservoir for the pixel. (Default: 2)*3", 0, 5, 1, curSettings.iReSTIRGI_SpatialNumSamples, defaultSettings.iReSTIRGI_SpatialNumSamples, function(state)
        curSettings.iReSTIRGI_SpatialNumSamples = state
		GameOptions.SetInt('Editor/ReSTIRGI', 'SpatialNumSamples', state)
    end)

	nativeSettings.addRangeInt("/CORPORAT/ReSTIRGI", "Target History Length","The number of past frames that ReSTIRGI aims to use for temporal reuse. (Default: 8)*4", 0, 16, 1, curSettings.iReSTIRGI_TargetHistoryLength, defaultSettings.iReSTIRGI_TargetHistoryLength, function(state)
        curSettings.iReSTIRGI_TargetHistoryLength = state
		GameOptions.SetInt('Editor/ReSTIRGI', 'TargetHistoryLength', state)
    end)


--Editor/ReGIR
	nativeSettings.addSwitch("/CORPORAT/ReGIR", "Enable ReGIR GI", "Controls whether ReGIR (Resampled Global Illumination Radiance) is active (Default: 'Off')*", curSettings.bReGIREnable, defaultSettings.bReGIREnable, function(state)
		curSettings.bReGIREnable = state
		GameOptions.SetBool('Editor/ReGIR', 'Enable', state)
    end)

	nativeSettings.addSwitch("/CORPORAT/ReGIR", "Enable ReGIR DI (requires GI)", "Controls whether ReGIR is applied for Direct Illumination in addition to Indirect Illumination. (Default: 'Off')", curSettings.bUseForDI, defaultSettings.bUseForDI, function(state)
        curSettings.bUseForDI = state
		GameOptions.SetBool('Editor/ReGIR', 'UseForDI', state)
    end)

   nativeSettings.addRangeInt("/CORPORAT/ReGIR", "ReGIR Light Slots", "How many local light slots. Below this will cause missing lights or light switching in some scenes (Default: 128)", 128, 256, 64, curSettings.iLightSlotsCount, defaultSettings.iLightSlotsCount, function(state)
        curSettings.iLightSlotsCount = state
		GameOptions.SetInt('Editor/ReGIR', 'LightSlotsCount', state)
    end)

    nativeSettings.addRangeInt("/CORPORAT/ReGIR", "ReGIR Shading Candidates", "This command sets the number of shading candidates for ReGIR sampling in the editor (Only builds shaders correctly on Default: 4)*16", 4, 24, 4, curSettings.iShadingCandidatesCount, defaultSettings.iShadingCandidatesCount, function(state)
        curSettings.iShadingCandidatesCount = state
		GameOptions.SetInt('Editor/ReGIR', 'ShadingCandidatesCount', state)
    end)

    nativeSettings.addRangeInt("/CORPORAT/ReGIR", "ReGIR Build Candidates", "Determines how many initial candidate positions are considered when constructing the ReGIR structure. (Default: 8)", 4, 8, 4, curSettings.iBuildCandidatesCount, defaultSettings.iBuildCandidatesCount, function(state)
        curSettings.iBuildCandidatesCount = state
		GameOptions.SetInt('Editor/ReGIR', 'BuildCandidatesCount', state)
    end)

--RayTracing/LocalLight
    nativeSettings.addRangeInt("/CORPORAT/LocalLight", "Local Lights Batch Size", "Defines how many local lights are processed together in a single batch. (Default: 64)*128", 64, 256, 64, curSettings.iLocalLight_BatchSize, defaultSettings.iLocalLight_BatchSize, function(state)
        curSettings.iLocalLight_BatchSize = state
		GameOptions.SetInt('RayTracing/LocalLight', 'BatchSize', state)
    end)

    nativeSettings.addRangeInt("/CORPORAT/LocalLight", "Capacity", "Sets the maximum number of local light sources that can be included in ray tracing passes. (Default: 128)*512", 64, 512, 64, curSettings.iLocalLight_Capacity, defaultSettings.iLocalLight_Capacity, function(state)
        curSettings.iLocalLight_Capacity = state
		GameOptions.SetInt('RayTracing/LocalLight', 'Capacity', state)
    end)

    nativeSettings.addRangeInt("/CORPORAT/LocalLight", "Grid Size", "Controls the size of the spatial grid used to organize/cull local lights before they are sampled. (Default: 16)", 16, 64, 16, curSettings.iLocalLight_GridSize, defaultSettings.iLocalLight_GridSize, function(state)
        curSettings.iLocalLight_GridSize = state
		GameOptions.SetInt('RayTracing/LocalLight', 'GridSize', state)
    end)

--[RayTracing/BlasCache]
    nativeSettings.addRangeInt("/CORPORAT/BlasCache", "Budget", "The BLAS (Bottom-Level Acceleration Structure) Cache Budget defines how much memory (VRAM) the game reserves for storing these acceleration structures. (Default: 900)", 900, 1800, 1, curSettings.iBlasCache_Budget_display, defaultSettings.iBlasCache_Budget_display, function(state)
        curSettings.iBlasCache_Budget_display = (state)
        curSettings.iBlasCache_Budget = ((state*1024)*1024)
		GameOptions.SetInt('RayTracing/BlasCache', 'Budget', ((state*1024)*1024))
    end)

    nativeSettings.addRangeInt("/CORPORAT/BlasCache", "Reserve", "The specific parameter being set; controls how much VRAM is reserved for the BLAS cache, even if it’s not currently used. (Default: 150)", 150, 300, 1, curSettings.iBlasCache_Budget_Reserve_display, defaultSettings.iBlasCache_Budget_Reserve_display, function(state)
        curSettings.iBlasCache_Budget_Reserve_display = (state)
        curSettings.iBlasCache_Budget_Reserve = ((state*1024)*1024)
		GameOptions.SetInt('RayTracing/BlasCache', 'Reserve', ((state*1024)*1024))
    end)

	nativeSettings.addSwitch("/CORPORAT/ReBLUR", "Reference Accumulation", "It makes NRD accumulate ideal lighting data frame-by-frame, ignoring temporal reprojection and noise thresholds — to produce a stable 'reference' image for comparison or validation. (Default: 'Off')", curSettings.bReBLUR_ReferenceAccumulation, defaultSettings.bReBLUR_ReferenceAccumulation, function(state)
		curSettings.bReBLUR_ReferenceAccumulation = state
		GameOptions.SetBool('Editor/Denoising/ReBLUR/Direct', 'ReferenceAccumulation', state)
    end)

--VariableRateShading
	nativeSettings.addSwitch("/CORPORAT/VRS", "Enable", "Variable Rate Shading is a DirectX 12 feature that allows the GPU to vary the shading rate per region of the screen instead of shading every pixel individually. (Default: 'On')", curSettings.bVRS_Enable, defaultSettings.bVRS_Enable, function(state)
		curSettings.bVRS_Enable = state
		GameOptions.SetBool('Rendering/VariableRateShading', 'Enable', state)
    end)

	nativeSettings.addRangeFloat("/CORPORAT/VRS", "Variance Cutoff", "This setting defines how much visual variance (color/luminance/motion change) the VRS system tolerates before increasing the shading rate. (Default: 0.025)", 0.001, 1.0, 0.001, "%.3f", curSettings.fVRS_VarianceCutoff, defaultSettings.fVRS_VarianceCutoff, function(state)
		curSettings.fVRS_VarianceCutoff = state
		GameOptions.SetFloat('Rendering/VariableRateShading', 'VarianceCutoff', state)
    end)

	nativeSettings.addRangeFloat("/CORPORAT/VRS", "Motion Factor", "The Motion Factor defines how much on-screen movement (player movement, object animation, camera panning) influences the shading rate reduction. (Default: 0.75)", 0.0, 1.0, .01, "%.2f", curSettings.fVRS_MotionFactor, defaultSettings.fVRS_MotionFactor, function(state)
		curSettings.fVRS_MotionFactor = state
		GameOptions.SetFloat('Rendering/VariableRateShading', 'MotionFactor', state)
    end)

	nativeSettings.addRangeFloat("/CORPORAT/VRS", "Screen Edge Factor", "The ScreenEdgeFactor tells the VRS system how aggressively it should lower shading rates near the borders of the frame. (Default: 1.0)", 0, 2, .1, "%.1f", curSettings.fVRS_ScreenEdgeFactor, defaultSettings.fVRS_ScreenEdgeFactor, function(state)
		curSettings.fVRS_ScreenEdgeFactor = state
		GameOptions.SetFloat('Rendering/VariableRateShading', 'ScreenEdgeFactor', state)
    end)

--Editor/Characters/Hair
	nativeSettings.addSwitch("/CORPORAT/Hair", "Hair Reference Implementation", "Determines whether the editor uses a reference hair shading/rendering method rather than the optimized runtime implementation. (Default: 'Off')*", curSettings.bUseReferenceImplementation, defaultSettings.bUseReferenceImplementation, function(state)
		curSettings.bUseReferenceImplementation = state
		GameOptions.SetBool('Editor/Characters/Hair', 'UseReferenceImplementation', state)
	 end)

    nativeSettings.addRangeFloat("/CORPORAT/Hair", "Hair Albedo Multiplier", "Multiplies the base color (albedo) of the hair material. Higher values (>1.0) = Hair appears brighter and more saturated. Lower values (<1.0) = Hair appears darker or muted. (Default: 1.0)", 0.01, 2.0, 0.01, "%.2f", curSettings.fAlbedoMultiplier, defaultSettings.fAlbedoMultiplier, function(state)
        curSettings.fAlbedoMultiplier = state
		GameOptions.SetFloat('Editor/Characters/Hair', 'AlbedoMultiplier', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/Hair", "Hair Roughness Factor", "Controls the micro-surface roughness of hair strands. Affects how specular highlights spread: Higher values = rougher hair, broader, softer highlights. Lower values = smoother hair, sharper, tighter highlights. (Default: 1.0)*3.0", 0.1, 3.0, 0.1, "%.2f", curSettings.fRoughnessFactor, defaultSettings.fRoughnessFactor, function(state)
        curSettings.fRoughnessFactor = state
		GameOptions.SetFloat('Editor/Characters/Hair', 'RoughnessFactor', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/Hair", "Hair Additional Area Roughness", "Higher values = Hair highlights are softer and more diffuse. (Default: 0.10)*0.3", 0.01, 1.0, 0.01, "%.2f", curSettings.fAdditionalAreaRoughness, defaultSettings.fAdditionalAreaRoughness, function(state)
        curSettings.fAdditionalAreaRoughness = state
		GameOptions.SetFloat('Editor/Characters/Hair', 'AdditionalAreaRoughness', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/Hair", "Hair Specular Random Min" ,"Defines the minimum variation in specular highlights across hair strands. Works together with SpecularRandom_Max to control the range of randomness. (Default: -0.2)", -1.0, 0.0, 0.01, "%.2f", curSettings.fSpecularRandom_Min, defaultSettings.fSpecularRandom_Min, function(state)
        curSettings.fSpecularRandom_Min = state
		GameOptions.SetFloat('Editor/Characters/Hair', 'SpecularRandom_Min', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/Hair", "Hair Specular Random Max", "Defines the maximum variation in specular highlights across hair strands. Introduces subtle randomness to prevent hair from looking overly uniform or artificial. (Default: 0.2)", 0.0, 1.0, 0.01, "%.2f", curSettings.fSpecularRandom_Max, defaultSettings.fSpecularRandom_Max, function(state)
        curSettings.fSpecularRandom_Max = state
		GameOptions.SetFloat('Editor/Characters/Hair', 'SpecularRandom_Max', state)
    end)
	
	nativeSettings.addSwitch("/CORPORAT/Hair", "Use Global Contact Shadows On Hair", "Use Global Contact Shadows On Hair (Default: 'On')", curSettings.bUseGlobalContactShadowsOnHair, defaultSettings.bUseGlobalContactShadowsOnHair, function(state)
		curSettings.bUseGlobalContactShadowsOnHair = state
		GameOptions.SetBool('Editor/Characters/Hair', 'UseGlobalContactShadowsOnHair', state)
	end)

	nativeSettings.addRangeFloat("/CORPORAT/Hair", "Contact Shadow Clamp", "Limits how dark or strong contact shadows can get (Default: 0.35)", 0.01, 1.0, 0.01, "%.2f", curSettings.fContactShadowClamp, defaultSettings.fContactShadowClamp, function(state)
		curSettings.fContactShadowClamp = state
		GameOptions.SetFloat('Editor/Characters/Hair', 'ContactShadowClamp', state)
	end)

--Editor/Characters/Hair/Specular
    nativeSettings.addRangeFloat("/CORPORAT/HairSpecular", "Hair Specular Wrap" ,"Higher values result in specular reflection spreading more around the hair surface, creating softer, more diffuse highlights.(Default: 0.3)*0.1", 0.0, 1.0, 0.01, "%.2f", curSettings.fECHS_Wrap, defaultSettings.fECHS_Wrap, function(state)
        curSettings.fECHS_Wrap = state
		GameOptions.SetFloat('Editor/Characters/Hair/Specular', 'Wrap', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/HairSpecular", "Hair Specular Mask Intensity" ,"Higher values produce brighter, more pronounced specular highlights (Default: 1.0)", 0.0, 1.0, 0.01, "%.2f", curSettings.fECHS_Mask_Intensity, defaultSettings.fECHS_Mask_Intensity, function(state)
        curSettings.fECHS_Mask_Intensity = state
		GameOptions.SetFloat('Editor/Characters/Hair/Specular', 'Mask_Intensity', state)
    end)

--[Editor/Characters/Hair/MultiScatter]
    nativeSettings.addRangeFloat("/CORPORAT/HairMultiScatter", "Hair MultiScatter Wrap" ,"Multi-scattering simulates how light bounces between hair strands, producing more realistic highlights. (Default: 0.3)", 0.0, 1.0, 0.01, "%.2f", curSettings.fECHM_Wrap, defaultSettings.fECHM_Wrap, function(state)
        curSettings.fECHM_Wrap = state
		GameOptions.SetFloat('Editor/Characters/Hair/MultiScatter', 'Wrap', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/HairMultiScatter", "Hair MultiScatter Mask Intensity" ,"Hair MultiScatter Mask Intensity (Default: 1.0)", 0.0, 1.0, 0.01, "%.2f", curSettings.fECHM_Mask_Intensity, defaultSettings.fECHM_Mask_Intensity, function(state)
        curSettings.fECHM_Mask_Intensity = state
		GameOptions.SetFloat('Editor/Characters/Hair/MultiScatter', 'Mask_Intensity', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/HairMultiScatter", "Hair MultiScatter Diffuse Factor" ,"Diffuse Scatter Factor (Reflect in different directions) (Default: 0.0)", 0.0, 1.0, 0.01, "%.2f", curSettings.fECHM_DiffuseScatterFactor, defaultSettings.fECHM_DiffuseScatterFactor, function(state)
        curSettings.fECHM_DiffuseScatterFactor = state
		GameOptions.SetFloat('Editor/Characters/Hair/MultiScatter', 'DiffuseScatterFactor', state)
    end)

--[Editor/Characters/Hair/EnvProbe]
	nativeSettings.addRangeFloat("/CORPORAT/HairEnvProbe", "Hair Environment Probe R" ,"Hair Environment Probe R (Default: 0.3)*0.33", 0.0, 1.0, 0.01, "%.2f", curSettings.fECHE_R, defaultSettings.fECHE_R, function(state)
		curSettings.fECHE_R = state
		GameOptions.SetFloat('Editor/Characters/Hair/EnvProbe', 'R', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/HairEnvProbe", "Hair Environment Probe TT", "Hair Environment Probe TT (Default: 0.005)", 0.0, 0.10, 0.001, "%.3f", curSettings.fECHE_TT, defaultSettings.fECHE_TT, function(state)
        curSettings.fECHE_TT = state
		GameOptions.SetFloat('Editor/Characters/Hair/EnvProbe', 'TT', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/HairEnvProbe", "Hair Environment Probe TRT" ,"Hair Environment Probe TRT (Default: 0.8))", -1.0, 1.0, 0.01, "%.2f", curSettings.fECHE_TRT, defaultSettings.fECHE_TRT, function(state)
        curSettings.fECHE_TRT = state
		GameOptions.SetFloat('Editor/Characters/Hair/EnvProbe', 'TRT', state)
    end)

   nativeSettings.addRangeFloat("/CORPORAT/HairEnvProbe", "Hair Environment Probe Multi Scatter" ,"Hair Environment Probe Multi Scatter (Default: 0.47)*0.45", 0.0, 1.0, 0.01, "%.2f", curSettings.fECHE_MultiScatter, defaultSettings.fECHE_MultiScatter, function(state)
        curSettings.fECHE_MultiScatter = state
		GameOptions.SetFloat('Editor/Characters/Hair/EnvProbe', 'MultiScatter', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/HairEnvProbe", "Hair Environment Probe Scatter Depth" ,"Hair Environment Probe Scatter Depth (Default: 1.3)", 0.0, 2.0, 0.01, "%.2f", curSettings.fECHE_ScatterDepth, defaultSettings.fECHE_ScatterDepth, function(state)
        curSettings.fECHE_ScatterDepth = state
		GameOptions.SetFloat('Editor/Characters/Hair/EnvProbe', 'ScatterDepth', state)
    end)

--[Editor/Characters/Hair/LocalLight]
	nativeSettings.addRangeFloat("/CORPORAT/HairLocalLight", "Hair Local Light R" ,"Hair Environment Probe R (Default: 0.35)*0.33", 0.0, 1.0, 0.01, "%.2f", curSettings.fECHL_R, defaultSettings.fECHL_R, function(state)
        curSettings.fECHL_R = state
		GameOptions.SetFloat('Editor/Characters/Hair/LocalLight', 'R', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/HairLocalLight", "Hair Local Light TT" ,"Hair Environment Probe TT (Default: 0.005)", 0.0, 0.10, 0.001, "%.3f", curSettings.fECHL_TT, defaultSettings.fECHL_TT, function(state)
        curSettings.fECHL_TT = state
		GameOptions.SetFloat('Editor/Characters/Hair/LocalLight', 'TT', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/HairLocalLight", "Hair Local Light TRT" ,"Hair Environment Probe TRT (Default: 0.8)*0.33", 0.0, 1.0, 0.01, "%.2f", curSettings.fECHL_TRT, defaultSettings.fECHL_TRT, function(state)
        curSettings.fECHL_TRT = state
		GameOptions.SetFloat('Editor/Characters/Hair/LocalLight', 'TRT', state)
    end)

	nativeSettings.addRangeFloat("/CORPORAT/HairLocalLight", "Hair Local Light Multi Scatter" ,"Multi Scatter (Default: 0.47)*0.45", -1.0, 1.0, 0.01, "%.2f", curSettings.fECHL_MultiScatter, defaultSettings.fECHL_MultiScatter, function(state)
        curSettings.fECHL_MultiScatter = state
		GameOptions.SetFloat('Editor/Characters/Hair/LocalLight', 'MultiScatter', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/HairLocalLight", "Hair Local Light Scatter Depth" ,"Hair Local Light Scatter Depth (Default: 0.8)", 0.0, 2.0, 0.01, "%.2f", curSettings.fECHL_ScatterDepth, defaultSettings.fECHL_ScatterDepth, function(state)
        curSettings.fECHL_ScatterDepth = state
		GameOptions.SetFloat('Editor/Characters/Hair/LocalLight', 'ScatterDepth', state)
    end)

--[Editor/Characters/Hair/GlobalLight]
    nativeSettings.addRangeFloat("/CORPORAT/HairGlobalLight", "Hair Global Light R" ,"Hair Local Light R (Default: 0.3)*0.35", -1.0, 1.0, 0.01, "%.2f", curSettings.fECHG_R, defaultSettings.fECHG_R, function(state)
        curSettings.fECHG_R = state
		GameOptions.SetFloat('Editor/Characters/Hair/GlobalLight', 'R', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/HairGlobalLight", "Hair Global Light TT" ,"Hair Local Light TT (Default: 0.005)", 0.0, 0.10, 0.001, "%.3f", curSettings.fECHG_TT, defaultSettings.fECHG_TT, function(state)        
		curSettings.fECHG_TT = state
		GameOptions.SetFloat('Editor/Characters/Hair/GlobalLight', 'TT', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/HairGlobalLight", "Hair Global Light TRT" ,"Hair Local Light TRT (Default: 0.8)", -1.0, 1.0, 0.01, "%.2f", curSettings.fECHG_TRT, defaultSettings.fECHG_TRT, function(state)
        curSettings.fECHG_TRT = state
		GameOptions.SetFloat('Editor/Characters/Hair/GlobalLight', 'TRT', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/HairGlobalLight", "Hair Global Light Multi Scatter" ,"Hair Local Light Multi Scatter (Default: 0.47)*0.45", -1.0, 1.0, 0.01, "%.2f", curSettings.fECHG_MultiScatter, defaultSettings.fECHG_MultiScatter, function(state)
        curSettings.fECHG_MultiScatter = state
		GameOptions.SetFloat('Editor/Characters/Hair/GlobalLight', 'MultiScatter', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/HairGlobalLight", "Hair Global Light Scatter Depth" ,"Hair Local Light Scatter Depth (Default: 1.25)", 0.0, 5.0, 0.01, "%.2f", curSettings.fECHG_ScatterDepth, defaultSettings.fECHG_ScatterDepth, function(state)
        curSettings.fECHG_ScatterDepth = state
		GameOptions.SetFloat('Editor/Characters/Hair/GlobalLight', 'ScatterDepth', state)
    end)

--[Editor/Characters/Hair/AlphaShifts]
    nativeSettings.addRangeFloat("/CORPORAT/HairAlphaShifts", "Hair Alpha Shifts R" ,"Hair Local Light R (Default: -0.083)*-0.083", -1.0, 1.0, 0.001, "%.3f", curSettings.fECHA_R, defaultSettings.fECHA_R, function(state)
        curSettings.fECHA_R = state
		GameOptions.SetFloat('Editor/Characters/Hair/AlphaShifts', 'R', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/HairAlphaShifts", "Hair Alpha Shifts TT" ,"Hair Local Light TT (Default: 1.0)", -1.0, 1.0, 0.01, "%.2f", curSettings.fECHA_TT, defaultSettings.fECHA_TT, function(state)
        curSettings.fECHA_TT = state
		GameOptions.SetFloat('Editor/Characters/Hair/AlphaShifts', 'TT', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/HairAlphaShifts", "Hair Alpha Shifts TRT" ,"Hair Alpha Shifts TRT (Default: -0.5)*-0.065", -1.0, 0.0, 0.001, "%.3f", curSettings.fECHA_TRT, defaultSettings.fECHA_TRT, function(state)
        curSettings.fECHA_TRT = state
		GameOptions.SetFloat('Editor/Characters/Hair/AlphaShifts', 'TRT', state)
    end)

--[Editor/Characters/Hair/HACKS]
    nativeSettings.addSwitch("/CORPORAT/HairHacks", "Enable Modified Local Light Intensity on hair", "Enables or disables Modified LocalLight Intensity hack on hair (Default: 'On')*", curSettings.bECHH_AAAA_HACK_hairModifiedLocalLightIntensity, defaultSettings.bECHH_AAAA_HACK_hairModifiedLocalLightIntensity, function(state)
		curSettings.bECHH_AAAA_HACK_hairModifiedLocalLightIntensity = state
		GameOptions.SetBool('Editor/Characters/Hair/HACKS', 'AAAA_HACK_hairModifiedLocalLightIntensity', state)
	end)

--[Editor/Characters/Hair/TRT_Params]
    nativeSettings.addRangeFloat("/CORPORAT/TRT_Params", "EXP_SCALE" ,"EXP_SCALE (Default: 1.0)*0.0", 0, 3.0, 0.1, "%.1f", curSettings.fTRT_Params_EXP_SCALE, defaultSettings.fTRT_Params_EXP_SCALE, function(state)
        curSettings.fTRT_Params_EXP_SCALE = state
		GameOptions.SetFloat('Editor/Characters/Hair/TRT_Params', 'EXP_SCALE', state)
    end)

    nativeSettings.addRangeFloat("/CORPORAT/TRT_Params", "EXP_BIAS" ,"EXP_BIAS (Default: 1.5)*1.0", 0, 2.0, 0.1, "%.1f", curSettings.fTRT_Params_EXP_BIAS, defaultSettings.fTRT_Params_EXP_BIAS, function(state)
        curSettings.fTRT_Params_EXP_BIAS = state
		GameOptions.SetFloat('Editor/Characters/Hair/TRT_Params', 'EXP_BIAS', state)
    end)

--[Editor/Characters/Eyes]
    nativeSettings.addSwitch("/CORPORAT/Eyes", "Use Ambient Occlusion On Eyes", "Use Ambient Occlusion On Eyes (Default: 'Off')", curSettings.bUseAOOnEyes, defaultSettings.bUseAOOnEyes, function(state)
		curSettings.bUseAOOnEyes = state
		GameOptions.SetBool('Editor/Characters/Eyes', 'UseAOOnEyes', state)
	end)

    nativeSettings.addRangeFloat("/CORPORAT/Eyes", "Diffuse Boost" ,"Diffuse Boost (Default: 0.1)*0.05", 0, 1.0, 0.01, "%.2f", curSettings.fECE_DiffuseBoost, defaultSettings.fECE_DiffuseBoost, function(state)
        curSettings.fECE_DiffuseBoost = state
		GameOptions.SetFloat('Editor/Characters/Eyes', 'DiffuseBoost', state)
    end)

--Skin
	nativeSettings.addSwitch("/CORPORAT/Skin1", "Enable Ambient Skin Mix", "This flag controls whether ambient lighting (environment light probes, sky contribution, bounced GI) is allowed to mix into the skin shading model. (Default: 'On')*", curSettings.bECS_AllowSkinAmbientMix, defaultSettings.bECS_AllowSkinAmbientMix, function(state)
		curSettings.bECS_AllowSkinAmbientMix = state
		GameOptions.SetBool('Editor/Characters/Skin', 'AllowSkinAmbientMix', state)
	 end)

	nativeSettings.addRangeFloat("/CORPORAT/Skin1", "Ambient Skin Mix Factor", "Skin picks up more of the ambient environment light, appearing softer, more evenly lit, and sometimes a bit 'washed' under strong ambient. (Default: 1.0)", 0, 1.0, 0.01, "%.2f", curSettings.fECS_SkinAmbientMix_Factor, defaultSettings.fECS_SkinAmbientMix_Factor, function(state)
		curSettings.fECS_SkinAmbientMix_Factor = state
		GameOptions.SetFloat('Editor/Characters/Skin', 'SkinAmbientMix_Factor', state)
	end)

	nativeSettings.addRangeFloat("/CORPORAT/Skin1", "Subsurface Specular Tint Weight", "Subsurface Specular Tint Weight (Default: 0.3)", 0, 1.0, 0.01, "%.2f", curSettings.fECS_SubsurfaceSpecularTintWeight, defaultSettings.fECS_SubsurfaceSpecularTintWeight, function(state)
		curSettings.fECS_SubsurfaceSpecularTintWeight = state
		GameOptions.SetFloat('Editor/Characters/Skin', 'SubsurfaceSpecularTintWeight', state)
	end)

	nativeSettings.addRangeFloat("/CORPORAT/Skin1", "Skin Ambient Intensity Factor", "Skin Ambient Intensity Factor (Default: 0.4)", 0, 1.0, 0.01, "%.2f", curSettings.fECS_SkinAmbientIntensity_Factor, defaultSettings.fECS_SkinAmbientIntensity_Factor, function(state)
		curSettings.fECS_SkinAmbientIntensity_Factor = state
		GameOptions.SetFloat('Editor/Characters/Skin', 'SkinAmbientIntensity_Factor', state)
	end)

	nativeSettings.addRangeFloat("/CORPORAT/Skin1", "Subsurface Specular Tint R", "Subsurface Specular Tint R (Default: 0.21)*0.27", 0, 1.0, 0.01, "%.2f", curSettings.fECS_SubsurfaceSpecularTint_R, defaultSettings.fECS_SubsurfaceSpecularTint_R, function(state)
		curSettings.fECS_SubsurfaceSpecularTint_R = state
		GameOptions.SetFloat('Editor/Characters/Skin', 'SubsurfaceSpecularTint_R', state)
	end)

	nativeSettings.addRangeFloat("/CORPORAT/Skin1", "Subsurface Specular Tint G", "Subsurface Specular Tint G (Default: 0.21)*0.27", 0, 1.0, 0.01, "%.2f", curSettings.fECS_SubsurfaceSpecularTint_G, defaultSettings.fECS_SubsurfaceSpecularTint_G, function(state)
		curSettings.fECS_SubsurfaceSpecularTint_G = state
		GameOptions.SetFloat('Editor/Characters/Skin', 'SubsurfaceSpecularTint_G', state)
	end)

	nativeSettings.addRangeFloat("/CORPORAT/Skin1", "Subsurface Specular Tint B", "Subsurface Specular Tint B (Default: 0.29)*0.31", 0, 1.0, 0.01, "%.2f", curSettings.fECS_SubsurfaceSpecularTint_B, defaultSettings.fECS_SubsurfaceSpecularTint_B, function(state)
		curSettings.fECS_SubsurfaceSpecularTint_B = state
		GameOptions.SetFloat('Editor/Characters/Skin', 'SubsurfaceSpecularTint_B', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/NRD", "Enable Scaling Compensation", "NRD tries to adjust its denoising to account for resolution differences or scaled reprojection history, helping prevent ghosting, blur, or undersampling artifacts. (Default: 'On')*", curSettings.bEnableScalingCompensation, defaultSettings.bEnableScalingCompensation, function(state)
		curSettings.bEnableScalingCompensation = state
		GameOptions.SetBool('Editor/Denoising/NRD', 'EnableScalingCompensation', state)
	end)

	nativeSettings.addSwitch("/CORPORAT/Rendering", "Checkerboard GI", "When enabled (true) the GI pass is rendered in a checkerboard pattern (half-resolution, interleaved pixels) and then reconstructed/upscaled to full resolution. (Default: 'On')", curSettings.bCheckerboardGI, defaultSettings.bCheckerboardGI, function(state)
		curSettings.bCheckerboardGI = state
		GameOptions.SetBool('Rendering', 'CheckerboardGI', state)
	end)

	nativeSettings.addRangeFloat("/CORPORAT/FoliageParameters", "Contact Shadow Clamp", "Limits how dark or strong contact shadows can get (Default: 0.6)", 0.01, 1.0, 0.01, "%.2f", curSettings.foliage_ContactShadowClamp, defaultSettings.foliage_ContactShadowClamp, function(state)
		curSettings.foliage_ContactShadowClamp = state
		GameOptions.SetFloat('Editor/FoliageParameters', 'ContactShadowClamp', state)
	end)

	nativeSettings.addButton("/CORPORAT", "Raster", "Best Quality Raster", "Raster", 45, function()
		curSettings = LoadFile("Data/raster.json")
		SaveFile("Data/config.json", curSettings)
		Visuals.InitSettings()
	end)

	nativeSettings.addButton("/CORPORAT", "Raytracing", "Best Quality Pathtracing", "Raytracing", 45, function()
		curSettings = LoadFile("Data/raytracing.json")
		SaveFile("Data/config.json", curSettings)
		Visuals.InitSettings()
	end)

	nativeSettings.addButton("/CORPORAT", "Pathtracing", "Best Quality Pathtracing", "Pathtracing", 45, function()
		curSettings = LoadFile("Data/pathtracing.json")
		SaveFile("Data/config.json", curSettings)
		Visuals.InitSettings()
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

return CORPORAT:new()

