struct Color
    r::Cuchar
    g::Cuchar
    b::Cuchar
    a::Cuchar
end

mutable struct Vector2
    x::Cfloat
    y::Cfloat
end

mutable struct Vector3
    x::Cfloat
    y::Cfloat
    z::Cfloat
end

mutable struct Camera3D
    position::Vector3
    target::Vector3
    up::Vector3
    fovy::Cfloat
    projection::Cint
    Camera3D() = new()
end

const Camera = Camera3D

mutable struct Ray
    position::Vector3
    direction::Vector3
end

function GetScreenToWorldRay(position, camera)
    @ccall libraylib.GetScreenToWorldRay(position::Vector2, camera::Camera)::Ray
end

mutable struct Vector4
    x::Cfloat
    y::Cfloat
    z::Cfloat
    w::Cfloat
end

const Quaternion = Vector4

function Base.getproperty(x::Ptr{Quaternion}, f::Symbol)
    f === :x && return Ptr{Cfloat}(x + 0)
    f === :y && return Ptr{Cfloat}(x + 4)
    f === :z && return Ptr{Cfloat}(x + 8)
    f === :w && return Ptr{Cfloat}(x + 12)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{Quaternion}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct Matrix
    m0::Cfloat
    m4::Cfloat
    m8::Cfloat
    m12::Cfloat
    m1::Cfloat
    m5::Cfloat
    m9::Cfloat
    m13::Cfloat
    m2::Cfloat
    m6::Cfloat
    m10::Cfloat
    m14::Cfloat
    m3::Cfloat
    m7::Cfloat
    m11::Cfloat
    m15::Cfloat
end

mutable struct Rectangle
    x::Cfloat
    y::Cfloat
    width::Cfloat
    height::Cfloat
end

mutable struct Image
    data::Ptr{Cvoid}
    width::Cint
    height::Cint
    mipmaps::Cint
    format::Cint
end
function Base.getproperty(x::Ptr{Image}, f::Symbol)
    f === :data && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :width && return Ptr{Cint}(x + 8)
    f === :height && return Ptr{Cint}(x + 12)
    f === :mipmaps && return Ptr{Cint}(x + 16)
    f === :format && return Ptr{Cint}(x + 20)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{Image}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct Texture
    id::Cuint
    width::Cint
    height::Cint
    mipmaps::Cint
    format::Cint
end

const Texture2D = Texture

const TextureCubemap = Texture

struct RenderTexture
    id::Cuint
    texture::Texture
    depth::Texture
end

const RenderTexture2D = RenderTexture

struct NPatchInfo
    source::Rectangle
    left::Cint
    top::Cint
    right::Cint
    bottom::Cint
    layout::Cint
end

struct GlyphInfo
    value::Cint
    offsetX::Cint
    offsetY::Cint
    advanceX::Cint
    image::Image
end

struct Font
    baseSize::Cint
    glyphCount::Cint
    glyphPadding::Cint
    texture::Texture2D
    recs::Ptr{Rectangle}
    glyphs::Ptr{GlyphInfo}
end
function Base.getproperty(x::Ptr{Font}, f::Symbol)
    f === :baseSize && return Ptr{Cint}(x + 0)
    f === :glyphCount && return Ptr{Cint}(x + 4)
    f === :glyphPadding && return Ptr{Cint}(x + 8)
    f === :texture && return Ptr{Texture2D}(x + 12)
    f === :recs && return Ptr{Ptr{Rectangle}}(x + 32)
    f === :glyphs && return Ptr{Ptr{GlyphInfo}}(x + 40)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{Font}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct Camera2D
    offset::Vector2
    target::Vector2
    rotation::Cfloat
    zoom::Cfloat
end

struct Mesh
    vertexCount::Cint
    triangleCount::Cint
    vertices::Ptr{Cfloat}
    texcoords::Ptr{Cfloat}
    texcoords2::Ptr{Cfloat}
    normals::Ptr{Cfloat}
    tangents::Ptr{Cfloat}
    colors::Ptr{Cuchar}
    indices::Ptr{Cushort}
    animVertices::Ptr{Cfloat}
    animNormals::Ptr{Cfloat}
    boneIds::Ptr{Cuchar}
    boneWeights::Ptr{Cfloat}
    boneMatrices::Ptr{Matrix}
    boneCount::Cint
    vaoId::Cuint
    vboId::Ptr{Cuint}
end
function Base.getproperty(x::Ptr{Mesh}, f::Symbol)
    f === :vertexCount && return Ptr{Cint}(x + 0)
    f === :triangleCount && return Ptr{Cint}(x + 4)
    f === :vertices && return Ptr{Ptr{Cfloat}}(x + 8)
    f === :texcoords && return Ptr{Ptr{Cfloat}}(x + 16)
    f === :texcoords2 && return Ptr{Ptr{Cfloat}}(x + 24)
    f === :normals && return Ptr{Ptr{Cfloat}}(x + 32)
    f === :tangents && return Ptr{Ptr{Cfloat}}(x + 40)
    f === :colors && return Ptr{Ptr{Cuchar}}(x + 48)
    f === :indices && return Ptr{Ptr{Cushort}}(x + 56)
    f === :animVertices && return Ptr{Ptr{Cfloat}}(x + 64)
    f === :animNormals && return Ptr{Ptr{Cfloat}}(x + 72)
    f === :boneIds && return Ptr{Ptr{Cuchar}}(x + 80)
    f === :boneWeights && return Ptr{Ptr{Cfloat}}(x + 88)
    f === :boneMatrices && return Ptr{Ptr{Matrix}}(x + 96)
    f === :boneCount && return Ptr{Cint}(x + 104)
    f === :vaoId && return Ptr{Cuint}(x + 108)
    f === :vboId && return Ptr{Ptr{Cuint}}(x + 112)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{Mesh}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct Shader
    id::Cuint
    locs::Ptr{Cint}
    Shader() = new()
end
function Base.getproperty(x::Ptr{Shader}, f::Symbol)
    f === :id && return Ptr{Cuint}(x + 0)
    f === :locs && return Ptr{Ptr{Cint}}(x + 8)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{Shader}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct MaterialMap
    texture::Texture2D
    color::Color
    value::Cfloat
end

mutable struct Material
    shader::Shader
    maps::Ptr{MaterialMap}
    params::NTuple{4,Cfloat}
end
function Base.getproperty(x::Ptr{Material}, f::Symbol)
    f === :shader && return Ptr{Shader}(x + 0)
    f === :maps && return Ptr{Ptr{MaterialMap}}(x + 16)
    f === :params && return Ptr{NTuple{4,Cfloat}}(x + 24)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{Material}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct Transform
    translation::Vector3
    rotation::Quaternion
    scale::Vector3
end

function Base.getproperty(x::Ptr{Transform}, f::Symbol)
    f === :translation && return Ptr{Vector3}(x + 0)
    f === :rotation && return Ptr{Quaternion}(x + 12)
    f === :scale && return Ptr{Vector3}(x + 28)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{Transform}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct BoneInfo
    name::NTuple{32,Cchar}
    parent::Cint
end
function Base.getproperty(x::Ptr{BoneInfo}, f::Symbol)
    f === :name && return Ptr{NTuple{32,Cchar}}(x + 0)
    f === :parent && return Ptr{Cint}(x + 32)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{BoneInfo}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end
mutable struct Model
    transform::Matrix
    meshCount::Cint
    materialCount::Cint
    meshes::Ptr{Mesh}
    materials::Ptr{Material}
    meshMaterial::Ptr{Cint}
    boneCount::Cint
    bones::Ptr{BoneInfo}
    bindPose::Ptr{Transform}
end
function Base.getproperty(x::Ptr{Model}, f::Symbol)
    f === :transform && return Ptr{Matrix}(x + 0)
    f === :meshCount && return Ptr{Cint}(x + 64)
    f === :materialCount && return Ptr{Cint}(x + 68)
    f === :meshes && return Ptr{Ptr{Mesh}}(x + 72)
    f === :materials && return Ptr{Ptr{Material}}(x + 80)
    f === :meshMaterial && return Ptr{Ptr{Cint}}(x + 88)
    f === :boneCount && return Ptr{Cint}(x + 96)
    f === :bones && return Ptr{Ptr{BoneInfo}}(x + 104)
    f === :bindPose && return Ptr{Ptr{Transform}}(x + 112)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{Model}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ModelAnimation
    boneCount::Cint
    frameCount::Cint
    bones::Ptr{BoneInfo}
    framePoses::Ptr{Ptr{Transform}}
    name::NTuple{32,Cchar}
end
function Base.getproperty(x::Ptr{ModelAnimation}, f::Symbol)
    f === :boneCount && return Ptr{Cint}(x + 0)
    f === :frameCount && return Ptr{Cint}(x + 4)
    f === :bones && return Ptr{Ptr{BoneInfo}}(x + 8)
    f === :framePoses && return Ptr{Ptr{Ptr{Transform}}}(x + 16)
    f === :name && return Ptr{NTuple{32,Cchar}}(x + 24)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ModelAnimation}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct RayCollision
    hit::Bool
    distance::Cfloat
    point::Vector3
    normal::Vector3
end

struct BoundingBox
    min::Vector3
    max::Vector3
end

struct Wave
    frameCount::Cuint
    sampleRate::Cuint
    sampleSize::Cuint
    channels::Cuint
    data::Ptr{Cvoid}
end
function Base.getproperty(x::Ptr{Wave}, f::Symbol)
    f === :frameCount && return Ptr{Cuint}(x + 0)
    f === :sampleRate && return Ptr{Cuint}(x + 4)
    f === :sampleSize && return Ptr{Cuint}(x + 8)
    f === :channels && return Ptr{Cuint}(x + 12)
    f === :data && return Ptr{Ptr{Cvoid}}(x + 16)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{Wave}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const rAudioBuffer = Cvoid

const rAudioProcessor = Cvoid

struct AudioStream
    buffer::Ptr{rAudioBuffer}
    processor::Ptr{rAudioProcessor}
    sampleRate::Cuint
    sampleSize::Cuint
    channels::Cuint
end
function Base.getproperty(x::Ptr{AudioStream}, f::Symbol)
    f === :buffer && return Ptr{Ptr{rAudioBuffer}}(x + 0)
    f === :processor && return Ptr{Ptr{rAudioProcessor}}(x + 8)
    f === :sampleRate && return Ptr{Cuint}(x + 16)
    f === :sampleSize && return Ptr{Cuint}(x + 20)
    f === :channels && return Ptr{Cuint}(x + 24)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{AudioStream}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct Sound
    stream::AudioStream
    frameCount::Cuint
end

struct Music
    stream::AudioStream
    frameCount::Cuint
    looping::Bool
    ctxType::Cint
    ctxData::Ptr{Cvoid}
end
function Base.getproperty(x::Ptr{Music}, f::Symbol)
    f === :stream && return Ptr{AudioStream}(x + 0)
    f === :frameCount && return Ptr{Cuint}(x + 32)
    f === :looping && return Ptr{Bool}(x + 36)
    f === :ctxType && return Ptr{Cint}(x + 40)
    f === :ctxData && return Ptr{Ptr{Cvoid}}(x + 48)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{Music}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct VrDeviceInfo
    hResolution::Cint
    vResolution::Cint
    hScreenSize::Cfloat
    vScreenSize::Cfloat
    eyeToScreenDistance::Cfloat
    lensSeparationDistance::Cfloat
    interpupillaryDistance::Cfloat
    lensDistortionValues::NTuple{4,Cfloat}
    chromaAbCorrection::NTuple{4,Cfloat}
end

struct VrStereoConfig
    projection::NTuple{2,Matrix}
    viewOffset::NTuple{2,Matrix}
    leftLensCenter::NTuple{2,Cfloat}
    rightLensCenter::NTuple{2,Cfloat}
    leftScreenCenter::NTuple{2,Cfloat}
    rightScreenCenter::NTuple{2,Cfloat}
    scale::NTuple{2,Cfloat}
    scaleIn::NTuple{2,Cfloat}
end

struct FilePathList
    capacity::Cuint
    count::Cuint
    paths::Ptr{Ptr{Cchar}}
end
function Base.getproperty(x::Ptr{FilePathList}, f::Symbol)
    f === :capacity && return Ptr{Cuint}(x + 0)
    f === :count && return Ptr{Cuint}(x + 4)
    f === :paths && return Ptr{Ptr{Ptr{Cchar}}}(x + 8)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{FilePathList}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct AutomationEvent
    frame::Cuint
    type::Cuint
    params::NTuple{4,Cint}
end

struct AutomationEventList
    capacity::Cuint
    count::Cuint
    events::Ptr{AutomationEvent}
end
function Base.getproperty(x::Ptr{AutomationEventList}, f::Symbol)
    f === :capacity && return Ptr{Cuint}(x + 0)
    f === :count && return Ptr{Cuint}(x + 4)
    f === :events && return Ptr{Ptr{AutomationEvent}}(x + 8)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{AutomationEventList}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const ConfigFlags = UInt32
const FLAG_VSYNC_HINT::ConfigFlags = 64
const FLAG_FULLSCREEN_MODE::ConfigFlags = 2
const FLAG_WINDOW_RESIZABLE::ConfigFlags = 4
const FLAG_WINDOW_UNDECORATED::ConfigFlags = 8
const FLAG_WINDOW_HIDDEN::ConfigFlags = 128
const FLAG_WINDOW_MINIMIZED::ConfigFlags = 512
const FLAG_WINDOW_MAXIMIZED::ConfigFlags = 1024
const FLAG_WINDOW_UNFOCUSED::ConfigFlags = 2048
const FLAG_WINDOW_TOPMOST::ConfigFlags = 4096
const FLAG_WINDOW_ALWAYS_RUN::ConfigFlags = 256
const FLAG_WINDOW_TRANSPARENT::ConfigFlags = 16
const FLAG_WINDOW_HIGHDPI::ConfigFlags = 8192
const FLAG_WINDOW_MOUSE_PASSTHROUGH::ConfigFlags = 16384
const FLAG_BORDERLESS_WINDOWED_MODE::ConfigFlags = 32768
const FLAG_MSAA_4X_HINT::ConfigFlags = 32
const FLAG_INTERLACED_HINT::ConfigFlags = 65536

const TraceLogLevel = UInt32
const LOG_ALL::TraceLogLevel = 0
const LOG_TRACE::TraceLogLevel = 1
const LOG_DEBUG::TraceLogLevel = 2
const LOG_INFO::TraceLogLevel = 3
const LOG_WARNING::TraceLogLevel = 4
const LOG_ERROR::TraceLogLevel = 5
const LOG_FATAL::TraceLogLevel = 6
const LOG_NONE::TraceLogLevel = 7

const KeyboardKey = UInt32
const KEY_NULL::KeyboardKey = 0
const KEY_APOSTROPHE::KeyboardKey = 39
const KEY_COMMA::KeyboardKey = 44
const KEY_MINUS::KeyboardKey = 45
const KEY_PERIOD::KeyboardKey = 46
const KEY_SLASH::KeyboardKey = 47
const KEY_ZERO::KeyboardKey = 48
const KEY_ONE::KeyboardKey = 49
const KEY_TWO::KeyboardKey = 50
const KEY_THREE::KeyboardKey = 51
const KEY_FOUR::KeyboardKey = 52
const KEY_FIVE::KeyboardKey = 53
const KEY_SIX::KeyboardKey = 54
const KEY_SEVEN::KeyboardKey = 55
const KEY_EIGHT::KeyboardKey = 56
const KEY_NINE::KeyboardKey = 57
const KEY_SEMICOLON::KeyboardKey = 59
const KEY_EQUAL::KeyboardKey = 61
const KEY_A::KeyboardKey = 65
const KEY_B::KeyboardKey = 66
const KEY_C::KeyboardKey = 67
const KEY_D::KeyboardKey = 68
const KEY_E::KeyboardKey = 69
const KEY_F::KeyboardKey = 70
const KEY_G::KeyboardKey = 71
const KEY_H::KeyboardKey = 72
const KEY_I::KeyboardKey = 73
const KEY_J::KeyboardKey = 74
const KEY_K::KeyboardKey = 75
const KEY_L::KeyboardKey = 76
const KEY_M::KeyboardKey = 77
const KEY_N::KeyboardKey = 78
const KEY_O::KeyboardKey = 79
const KEY_P::KeyboardKey = 80
const KEY_Q::KeyboardKey = 81
const KEY_R::KeyboardKey = 82
const KEY_S::KeyboardKey = 83
const KEY_T::KeyboardKey = 84
const KEY_U::KeyboardKey = 85
const KEY_V::KeyboardKey = 86
const KEY_W::KeyboardKey = 87
const KEY_X::KeyboardKey = 88
const KEY_Y::KeyboardKey = 89
const KEY_Z::KeyboardKey = 90
const KEY_LEFT_BRACKET::KeyboardKey = 91
const KEY_BACKSLASH::KeyboardKey = 92
const KEY_RIGHT_BRACKET::KeyboardKey = 93
const KEY_GRAVE::KeyboardKey = 96
const KEY_SPACE::KeyboardKey = 32
const KEY_ESCAPE::KeyboardKey = 256
const KEY_ENTER::KeyboardKey = 257
const KEY_TAB::KeyboardKey = 258
const KEY_BACKSPACE::KeyboardKey = 259
const KEY_INSERT::KeyboardKey = 260
const KEY_DELETE::KeyboardKey = 261
const KEY_RIGHT::KeyboardKey = 262
const KEY_LEFT::KeyboardKey = 263
const KEY_DOWN::KeyboardKey = 264
const KEY_UP::KeyboardKey = 265
const KEY_PAGE_UP::KeyboardKey = 266
const KEY_PAGE_DOWN::KeyboardKey = 267
const KEY_HOME::KeyboardKey = 268
const KEY_END::KeyboardKey = 269
const KEY_CAPS_LOCK::KeyboardKey = 280
const KEY_SCROLL_LOCK::KeyboardKey = 281
const KEY_NUM_LOCK::KeyboardKey = 282
const KEY_PRINT_SCREEN::KeyboardKey = 283
const KEY_PAUSE::KeyboardKey = 284
const KEY_F1::KeyboardKey = 290
const KEY_F2::KeyboardKey = 291
const KEY_F3::KeyboardKey = 292
const KEY_F4::KeyboardKey = 293
const KEY_F5::KeyboardKey = 294
const KEY_F6::KeyboardKey = 295
const KEY_F7::KeyboardKey = 296
const KEY_F8::KeyboardKey = 297
const KEY_F9::KeyboardKey = 298
const KEY_F10::KeyboardKey = 299
const KEY_F11::KeyboardKey = 300
const KEY_F12::KeyboardKey = 301
const KEY_LEFT_SHIFT::KeyboardKey = 340
const KEY_LEFT_CONTROL::KeyboardKey = 341
const KEY_LEFT_ALT::KeyboardKey = 342
const KEY_LEFT_SUPER::KeyboardKey = 343
const KEY_RIGHT_SHIFT::KeyboardKey = 344
const KEY_RIGHT_CONTROL::KeyboardKey = 345
const KEY_RIGHT_ALT::KeyboardKey = 346
const KEY_RIGHT_SUPER::KeyboardKey = 347
const KEY_KB_MENU::KeyboardKey = 348
const KEY_KP_0::KeyboardKey = 320
const KEY_KP_1::KeyboardKey = 321
const KEY_KP_2::KeyboardKey = 322
const KEY_KP_3::KeyboardKey = 323
const KEY_KP_4::KeyboardKey = 324
const KEY_KP_5::KeyboardKey = 325
const KEY_KP_6::KeyboardKey = 326
const KEY_KP_7::KeyboardKey = 327
const KEY_KP_8::KeyboardKey = 328
const KEY_KP_9::KeyboardKey = 329
const KEY_KP_DECIMAL::KeyboardKey = 330
const KEY_KP_DIVIDE::KeyboardKey = 331
const KEY_KP_MULTIPLY::KeyboardKey = 332
const KEY_KP_SUBTRACT::KeyboardKey = 333
const KEY_KP_ADD::KeyboardKey = 334
const KEY_KP_ENTER::KeyboardKey = 335
const KEY_KP_EQUAL::KeyboardKey = 336
const KEY_BACK::KeyboardKey = 4
const KEY_MENU::KeyboardKey = 5
const KEY_VOLUME_UP::KeyboardKey = 24
const KEY_VOLUME_DOWN::KeyboardKey = 25

const MouseButton = UInt32
const MOUSE_BUTTON_LEFT::MouseButton = 0
const MOUSE_BUTTON_RIGHT::MouseButton = 1
const MOUSE_BUTTON_MIDDLE::MouseButton = 2
const MOUSE_BUTTON_SIDE::MouseButton = 3
const MOUSE_BUTTON_EXTRA::MouseButton = 4
const MOUSE_BUTTON_FORWARD::MouseButton = 5
const MOUSE_BUTTON_BACK::MouseButton = 6

const MouseCursor = UInt32
const MOUSE_CURSOR_DEFAULT::MouseCursor = 0
const MOUSE_CURSOR_ARROW::MouseCursor = 1
const MOUSE_CURSOR_IBEAM::MouseCursor = 2
const MOUSE_CURSOR_CROSSHAIR::MouseCursor = 3
const MOUSE_CURSOR_POINTING_HAND::MouseCursor = 4
const MOUSE_CURSOR_RESIZE_EW::MouseCursor = 5
const MOUSE_CURSOR_RESIZE_NS::MouseCursor = 6
const MOUSE_CURSOR_RESIZE_NWSE::MouseCursor = 7
const MOUSE_CURSOR_RESIZE_NESW::MouseCursor = 8
const MOUSE_CURSOR_RESIZE_ALL::MouseCursor = 9
const MOUSE_CURSOR_NOT_ALLOWED::MouseCursor = 10

const GamepadButton = UInt32
const GAMEPAD_BUTTON_UNKNOWN::GamepadButton = 0
const GAMEPAD_BUTTON_LEFT_FACE_UP::GamepadButton = 1
const GAMEPAD_BUTTON_LEFT_FACE_RIGHT::GamepadButton = 2
const GAMEPAD_BUTTON_LEFT_FACE_DOWN::GamepadButton = 3
const GAMEPAD_BUTTON_LEFT_FACE_LEFT::GamepadButton = 4
const GAMEPAD_BUTTON_RIGHT_FACE_UP::GamepadButton = 5
const GAMEPAD_BUTTON_RIGHT_FACE_RIGHT::GamepadButton = 6
const GAMEPAD_BUTTON_RIGHT_FACE_DOWN::GamepadButton = 7
const GAMEPAD_BUTTON_RIGHT_FACE_LEFT::GamepadButton = 8
const GAMEPAD_BUTTON_LEFT_TRIGGER_1::GamepadButton = 9
const GAMEPAD_BUTTON_LEFT_TRIGGER_2::GamepadButton = 10
const GAMEPAD_BUTTON_RIGHT_TRIGGER_1::GamepadButton = 11
const GAMEPAD_BUTTON_RIGHT_TRIGGER_2::GamepadButton = 12
const GAMEPAD_BUTTON_MIDDLE_LEFT::GamepadButton = 13
const GAMEPAD_BUTTON_MIDDLE::GamepadButton = 14
const GAMEPAD_BUTTON_MIDDLE_RIGHT::GamepadButton = 15
const GAMEPAD_BUTTON_LEFT_THUMB::GamepadButton = 16
const GAMEPAD_BUTTON_RIGHT_THUMB::GamepadButton = 17

const GamepadAxis = UInt32
const GAMEPAD_AXIS_LEFT_X::GamepadAxis = 0
const GAMEPAD_AXIS_LEFT_Y::GamepadAxis = 1
const GAMEPAD_AXIS_RIGHT_X::GamepadAxis = 2
const GAMEPAD_AXIS_RIGHT_Y::GamepadAxis = 3
const GAMEPAD_AXIS_LEFT_TRIGGER::GamepadAxis = 4
const GAMEPAD_AXIS_RIGHT_TRIGGER::GamepadAxis = 5

const MaterialMapIndex = UInt32
const MATERIAL_MAP_ALBEDO::MaterialMapIndex = 0
const MATERIAL_MAP_METALNESS::MaterialMapIndex = 1
const MATERIAL_MAP_NORMAL::MaterialMapIndex = 2
const MATERIAL_MAP_ROUGHNESS::MaterialMapIndex = 3
const MATERIAL_MAP_OCCLUSION::MaterialMapIndex = 4
const MATERIAL_MAP_EMISSION::MaterialMapIndex = 5
const MATERIAL_MAP_HEIGHT::MaterialMapIndex = 6
const MATERIAL_MAP_CUBEMAP::MaterialMapIndex = 7
const MATERIAL_MAP_IRRADIANCE::MaterialMapIndex = 8
const MATERIAL_MAP_PREFILTER::MaterialMapIndex = 9
const MATERIAL_MAP_BRDF::MaterialMapIndex = 10

const ShaderLocationIndex = UInt32
const SHADER_LOC_VERTEX_POSITION::ShaderLocationIndex = 0
const SHADER_LOC_VERTEX_TEXCOORD01::ShaderLocationIndex = 1
const SHADER_LOC_VERTEX_TEXCOORD02::ShaderLocationIndex = 2
const SHADER_LOC_VERTEX_NORMAL::ShaderLocationIndex = 3
const SHADER_LOC_VERTEX_TANGENT::ShaderLocationIndex = 4
const SHADER_LOC_VERTEX_COLOR::ShaderLocationIndex = 5
const SHADER_LOC_MATRIX_MVP::ShaderLocationIndex = 6
const SHADER_LOC_MATRIX_VIEW::ShaderLocationIndex = 7
const SHADER_LOC_MATRIX_PROJECTION::ShaderLocationIndex = 8
const SHADER_LOC_MATRIX_MODEL::ShaderLocationIndex = 9
const SHADER_LOC_MATRIX_NORMAL::ShaderLocationIndex = 10
const SHADER_LOC_VECTOR_VIEW::ShaderLocationIndex = 11
const SHADER_LOC_COLOR_DIFFUSE::ShaderLocationIndex = 12
const SHADER_LOC_COLOR_SPECULAR::ShaderLocationIndex = 13
const SHADER_LOC_COLOR_AMBIENT::ShaderLocationIndex = 14
const SHADER_LOC_MAP_ALBEDO::ShaderLocationIndex = 15
const SHADER_LOC_MAP_METALNESS::ShaderLocationIndex = 16
const SHADER_LOC_MAP_NORMAL::ShaderLocationIndex = 17
const SHADER_LOC_MAP_ROUGHNESS::ShaderLocationIndex = 18
const SHADER_LOC_MAP_OCCLUSION::ShaderLocationIndex = 19
const SHADER_LOC_MAP_EMISSION::ShaderLocationIndex = 20
const SHADER_LOC_MAP_HEIGHT::ShaderLocationIndex = 21
const SHADER_LOC_MAP_CUBEMAP::ShaderLocationIndex = 22
const SHADER_LOC_MAP_IRRADIANCE::ShaderLocationIndex = 23
const SHADER_LOC_MAP_PREFILTER::ShaderLocationIndex = 24
const SHADER_LOC_MAP_BRDF::ShaderLocationIndex = 25
const SHADER_LOC_VERTEX_BONEIDS::ShaderLocationIndex = 26
const SHADER_LOC_VERTEX_BONEWEIGHTS::ShaderLocationIndex = 27
const SHADER_LOC_BONE_MATRICES::ShaderLocationIndex = 28

const ShaderUniformDataType = UInt32
const SHADER_UNIFORM_FLOAT::ShaderUniformDataType = 0
const SHADER_UNIFORM_VEC2::ShaderUniformDataType = 1
const SHADER_UNIFORM_VEC3::ShaderUniformDataType = 2
const SHADER_UNIFORM_VEC4::ShaderUniformDataType = 3
const SHADER_UNIFORM_INT::ShaderUniformDataType = 4
const SHADER_UNIFORM_IVEC2::ShaderUniformDataType = 5
const SHADER_UNIFORM_IVEC3::ShaderUniformDataType = 6
const SHADER_UNIFORM_IVEC4::ShaderUniformDataType = 7
const SHADER_UNIFORM_SAMPLER2D::ShaderUniformDataType = 8

const ShaderAttributeDataType = UInt32
const SHADER_ATTRIB_FLOAT::ShaderAttributeDataType = 0
const SHADER_ATTRIB_VEC2::ShaderAttributeDataType = 1
const SHADER_ATTRIB_VEC3::ShaderAttributeDataType = 2
const SHADER_ATTRIB_VEC4::ShaderAttributeDataType = 3

const PixelFormat = UInt32
const PIXELFORMAT_UNCOMPRESSED_GRAYSCALE::PixelFormat = 1
const PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA::PixelFormat = 2
const PIXELFORMAT_UNCOMPRESSED_R5G6B5::PixelFormat = 3
const PIXELFORMAT_UNCOMPRESSED_R8G8B8::PixelFormat = 4
const PIXELFORMAT_UNCOMPRESSED_R5G5B5A1::PixelFormat = 5
const PIXELFORMAT_UNCOMPRESSED_R4G4B4A4::PixelFormat = 6
const PIXELFORMAT_UNCOMPRESSED_R8G8B8A8::PixelFormat = 7
const PIXELFORMAT_UNCOMPRESSED_R32::PixelFormat = 8
const PIXELFORMAT_UNCOMPRESSED_R32G32B32::PixelFormat = 9
const PIXELFORMAT_UNCOMPRESSED_R32G32B32A32::PixelFormat = 10
const PIXELFORMAT_UNCOMPRESSED_R16::PixelFormat = 11
const PIXELFORMAT_UNCOMPRESSED_R16G16B16::PixelFormat = 12
const PIXELFORMAT_UNCOMPRESSED_R16G16B16A16::PixelFormat = 13
const PIXELFORMAT_COMPRESSED_DXT1_RGB::PixelFormat = 14
const PIXELFORMAT_COMPRESSED_DXT1_RGBA::PixelFormat = 15
const PIXELFORMAT_COMPRESSED_DXT3_RGBA::PixelFormat = 16
const PIXELFORMAT_COMPRESSED_DXT5_RGBA::PixelFormat = 17
const PIXELFORMAT_COMPRESSED_ETC1_RGB::PixelFormat = 18
const PIXELFORMAT_COMPRESSED_ETC2_RGB::PixelFormat = 19
const PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA::PixelFormat = 20
const PIXELFORMAT_COMPRESSED_PVRT_RGB::PixelFormat = 21
const PIXELFORMAT_COMPRESSED_PVRT_RGBA::PixelFormat = 22
const PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA::PixelFormat = 23
const PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA::PixelFormat = 24

const TextureFilter = UInt32
const TEXTURE_FILTER_POINT::TextureFilter = 0
const TEXTURE_FILTER_BILINEAR::TextureFilter = 1
const TEXTURE_FILTER_TRILINEAR::TextureFilter = 2
const TEXTURE_FILTER_ANISOTROPIC_4X::TextureFilter = 3
const TEXTURE_FILTER_ANISOTROPIC_8X::TextureFilter = 4
const TEXTURE_FILTER_ANISOTROPIC_16X::TextureFilter = 5

const TextureWrap = UInt32
const TEXTURE_WRAP_REPEAT::TextureWrap = 0
const TEXTURE_WRAP_CLAMP::TextureWrap = 1
const TEXTURE_WRAP_MIRROR_REPEAT::TextureWrap = 2
const TEXTURE_WRAP_MIRROR_CLAMP::TextureWrap = 3

const CubemapLayout = UInt32
const CUBEMAP_LAYOUT_AUTO_DETECT::CubemapLayout = 0
const CUBEMAP_LAYOUT_LINE_VERTICAL::CubemapLayout = 1
const CUBEMAP_LAYOUT_LINE_HORIZONTAL::CubemapLayout = 2
const CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR::CubemapLayout = 3
const CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE::CubemapLayout = 4

const FontType = UInt32
const FONT_DEFAULT::FontType = 0
const FONT_BITMAP::FontType = 1
const FONT_SDF::FontType = 2

const BlendMode = UInt32
const BLEND_ALPHA::BlendMode = 0
const BLEND_ADDITIVE::BlendMode = 1
const BLEND_MULTIPLIED::BlendMode = 2
const BLEND_ADD_COLORS::BlendMode = 3
const BLEND_SUBTRACT_COLORS::BlendMode = 4
const BLEND_ALPHA_PREMULTIPLY::BlendMode = 5
const BLEND_CUSTOM::BlendMode = 6
const BLEND_CUSTOM_SEPARATE::BlendMode = 7

const Gesture = UInt32
const GESTURE_NONE::Gesture = 0
const GESTURE_TAP::Gesture = 1
const GESTURE_DOUBLETAP::Gesture = 2
const GESTURE_HOLD::Gesture = 4
const GESTURE_DRAG::Gesture = 8
const GESTURE_SWIPE_RIGHT::Gesture = 16
const GESTURE_SWIPE_LEFT::Gesture = 32
const GESTURE_SWIPE_UP::Gesture = 64
const GESTURE_SWIPE_DOWN::Gesture = 128
const GESTURE_PINCH_IN::Gesture = 256
const GESTURE_PINCH_OUT::Gesture = 512

const CameraMode = UInt32
const CAMERA_CUSTOM::CameraMode = 0
const CAMERA_FREE::CameraMode = 1
const CAMERA_ORBITAL::CameraMode = 2
const CAMERA_FIRST_PERSON::CameraMode = 3
const CAMERA_THIRD_PERSON::CameraMode = 4

const CameraProjection = UInt32
const CAMERA_PERSPECTIVE::CameraProjection = 0
const CAMERA_ORTHOGRAPHIC::CameraProjection = 1

const NPatchLayout = UInt32
const NPATCH_NINE_PATCH::NPatchLayout = 0
const NPATCH_THREE_PATCH_VERTICAL::NPatchLayout = 1
const NPATCH_THREE_PATCH_HORIZONTAL::NPatchLayout = 2

# typedef void ( * TraceLogCallback ) ( int logLevel , const char * text , va_list args )
const TraceLogCallback = Ptr{Cvoid}

# typedef unsigned char * ( * LoadFileDataCallback ) ( const char * fileName , int * dataSize )
const LoadFileDataCallback = Ptr{Cvoid}

# typedef bool ( * SaveFileDataCallback ) ( const char * fileName , void * data , int dataSize )
const SaveFileDataCallback = Ptr{Cvoid}

# typedef char * ( * LoadFileTextCallback ) ( const char * fileName )
const LoadFileTextCallback = Ptr{Cvoid}

# typedef bool ( * SaveFileTextCallback ) ( const char * fileName , char * text )
const SaveFileTextCallback = Ptr{Cvoid}

function InitWindow(width, height, title)
    @ccall libraylib.InitWindow(width::Cint, height::Cint, title::Ptr{Cchar})::Cvoid
end

function CloseWindow()
    @ccall libraylib.CloseWindow()::Cvoid
end

function WindowShouldClose()
    @ccall libraylib.WindowShouldClose()::Bool
end

function IsWindowReady()
    @ccall libraylib.IsWindowReady()::Bool
end

function IsWindowFullscreen()
    @ccall libraylib.IsWindowFullscreen()::Bool
end

function IsWindowHidden()
    @ccall libraylib.IsWindowHidden()::Bool
end

function IsWindowMinimized()
    @ccall libraylib.IsWindowMinimized()::Bool
end

function IsWindowMaximized()
    @ccall libraylib.IsWindowMaximized()::Bool
end

function IsWindowFocused()
    @ccall libraylib.IsWindowFocused()::Bool
end

function IsWindowResized()
    @ccall libraylib.IsWindowResized()::Bool
end

function IsWindowState(flag)
    @ccall libraylib.IsWindowState(flag::Cuint)::Bool
end

function SetWindowState(flags)
    @ccall libraylib.SetWindowState(flags::Cuint)::Cvoid
end

function ClearWindowState(flags)
    @ccall libraylib.ClearWindowState(flags::Cuint)::Cvoid
end

function ToggleFullscreen()
    @ccall libraylib.ToggleFullscreen()::Cvoid
end

function ToggleBorderlessWindowed()
    @ccall libraylib.ToggleBorderlessWindowed()::Cvoid
end

function MaximizeWindow()
    @ccall libraylib.MaximizeWindow()::Cvoid
end

function MinimizeWindow()
    @ccall libraylib.MinimizeWindow()::Cvoid
end

function RestoreWindow()
    @ccall libraylib.RestoreWindow()::Cvoid
end

function SetWindowIcon(image)
    @ccall libraylib.SetWindowIcon(image::Image)::Cvoid
end

function SetWindowIcons(images, count)
    @ccall libraylib.SetWindowIcons(images::Ptr{Image}, count::Cint)::Cvoid
end

function SetWindowTitle(title)
    @ccall libraylib.SetWindowTitle(title::Ptr{Cchar})::Cvoid
end

function SetWindowPosition(x, y)
    @ccall libraylib.SetWindowPosition(x::Cint, y::Cint)::Cvoid
end

function SetWindowMonitor(monitor)
    @ccall libraylib.SetWindowMonitor(monitor::Cint)::Cvoid
end

function SetWindowMinSize(width, height)
    @ccall libraylib.SetWindowMinSize(width::Cint, height::Cint)::Cvoid
end

function SetWindowMaxSize(width, height)
    @ccall libraylib.SetWindowMaxSize(width::Cint, height::Cint)::Cvoid
end

function SetWindowSize(width, height)
    @ccall libraylib.SetWindowSize(width::Cint, height::Cint)::Cvoid
end

function SetWindowOpacity(opacity)
    @ccall libraylib.SetWindowOpacity(opacity::Cfloat)::Cvoid
end

function SetWindowFocused()
    @ccall libraylib.SetWindowFocused()::Cvoid
end

function GetWindowHandle()
    @ccall libraylib.GetWindowHandle()::Ptr{Cvoid}
end

function GetScreenWidth()
    @ccall libraylib.GetScreenWidth()::Cint
end

function GetScreenHeight()
    @ccall libraylib.GetScreenHeight()::Cint
end

function GetRenderWidth()
    @ccall libraylib.GetRenderWidth()::Cint
end

function GetRenderHeight()
    @ccall libraylib.GetRenderHeight()::Cint
end

function GetMonitorCount()
    @ccall libraylib.GetMonitorCount()::Cint
end

function GetCurrentMonitor()
    @ccall libraylib.GetCurrentMonitor()::Cint
end

function GetMonitorPosition(monitor)
    @ccall libraylib.GetMonitorPosition(monitor::Cint)::Vector2
end

function GetMonitorWidth(monitor)
    @ccall libraylib.GetMonitorWidth(monitor::Cint)::Cint
end

function GetMonitorHeight(monitor)
    @ccall libraylib.GetMonitorHeight(monitor::Cint)::Cint
end

function GetMonitorPhysicalWidth(monitor)
    @ccall libraylib.GetMonitorPhysicalWidth(monitor::Cint)::Cint
end

function GetMonitorPhysicalHeight(monitor)
    @ccall libraylib.GetMonitorPhysicalHeight(monitor::Cint)::Cint
end

function GetMonitorRefreshRate(monitor)
    @ccall libraylib.GetMonitorRefreshRate(monitor::Cint)::Cint
end

function GetWindowPosition()
    @ccall libraylib.GetWindowPosition()::Vector2
end

function GetWindowScaleDPI()
    @ccall libraylib.GetWindowScaleDPI()::Vector2
end

function GetMonitorName(monitor)
    @ccall libraylib.GetMonitorName(monitor::Cint)::Ptr{Cchar}
end

function SetClipboardText(text)
    @ccall libraylib.SetClipboardText(text::Ptr{Cchar})::Cvoid
end

function GetClipboardText()
    @ccall libraylib.GetClipboardText()::Ptr{Cchar}
end

function GetClipboardImage()
    @ccall libraylib.GetClipboardImage()::Image
end

function EnableEventWaiting()
    @ccall libraylib.EnableEventWaiting()::Cvoid
end

function DisableEventWaiting()
    @ccall libraylib.DisableEventWaiting()::Cvoid
end

function ShowCursor()
    @ccall libraylib.ShowCursor()::Cvoid
end

function HideCursor()
    @ccall libraylib.HideCursor()::Cvoid
end

function IsCursorHidden()
    @ccall libraylib.IsCursorHidden()::Bool
end

function EnableCursor()
    @ccall libraylib.EnableCursor()::Cvoid
end

function DisableCursor()
    @ccall libraylib.DisableCursor()::Cvoid
end

function IsCursorOnScreen()
    @ccall libraylib.IsCursorOnScreen()::Bool
end

function ClearBackground(color)
    @ccall libraylib.ClearBackground(color::Color)::Cvoid
end

function BeginDrawing()
    @ccall libraylib.BeginDrawing()::Cvoid
end

function EndDrawing()
    @ccall libraylib.EndDrawing()::Cvoid
end

function BeginMode2D(camera)
    @ccall libraylib.BeginMode2D(camera::Camera2D)::Cvoid
end

function EndMode2D()
    @ccall libraylib.EndMode2D()::Cvoid
end

function BeginMode3D(camera)
    @ccall libraylib.BeginMode3D(camera::Camera3D)::Cvoid
end

function EndMode3D()
    @ccall libraylib.EndMode3D()::Cvoid
end

function BeginTextureMode(target)
    @ccall libraylib.BeginTextureMode(target::RenderTexture2D)::Cvoid
end

function EndTextureMode()
    @ccall libraylib.EndTextureMode()::Cvoid
end

function BeginShaderMode(shader)
    @ccall libraylib.BeginShaderMode(shader::Shader)::Cvoid
end

function EndShaderMode()
    @ccall libraylib.EndShaderMode()::Cvoid
end

function BeginBlendMode(mode)
    @ccall libraylib.BeginBlendMode(mode::Cint)::Cvoid
end

function EndBlendMode()
    @ccall libraylib.EndBlendMode()::Cvoid
end

function BeginScissorMode(x, y, width, height)
    @ccall libraylib.BeginScissorMode(x::Cint, y::Cint, width::Cint, height::Cint)::Cvoid
end

function EndScissorMode()
    @ccall libraylib.EndScissorMode()::Cvoid
end

function BeginVrStereoMode(config)
    @ccall libraylib.BeginVrStereoMode(config::VrStereoConfig)::Cvoid
end

function EndVrStereoMode()
    @ccall libraylib.EndVrStereoMode()::Cvoid
end

function LoadVrStereoConfig(device)
    @ccall libraylib.LoadVrStereoConfig(device::VrDeviceInfo)::VrStereoConfig
end

function UnloadVrStereoConfig(config)
    @ccall libraylib.UnloadVrStereoConfig(config::VrStereoConfig)::Cvoid
end

function LoadShader(vsFileName, fsFileName)
    @ccall libraylib.LoadShader(vsFileName::Ptr{Cchar}, fsFileName::Ptr{Cchar})::Shader
end

function LoadShaderFromMemory(vsCode, fsCode)
    @ccall libraylib.LoadShaderFromMemory(vsCode::Ptr{Cchar}, fsCode::Ptr{Cchar})::Shader
end

function IsShaderValid(shader)
    @ccall libraylib.IsShaderValid(shader::Shader)::Bool
end

function GetShaderLocation(shader, uniformName)
    @ccall libraylib.GetShaderLocation(shader::Shader, uniformName::Ptr{Cchar})::Cint
end

function GetShaderLocationAttrib(shader, attribName)
    @ccall libraylib.GetShaderLocationAttrib(shader::Shader, attribName::Ptr{Cchar})::Cint
end

function SetShaderValue(shader, locIndex, value, uniformType)
    @ccall libraylib.SetShaderValue(
        shader::Shader, locIndex::Cint, value::Ptr{Cvoid}, uniformType::Cint)::Cvoid
end

function SetShaderValueV(shader, locIndex, value, uniformType, count)
    @ccall libraylib.SetShaderValueV(shader::Shader, locIndex::Cint, value::Ptr{Cvoid},
        uniformType::Cint, count::Cint)::Cvoid
end

function SetShaderValueMatrix(shader, locIndex, mat)
    @ccall libraylib.SetShaderValueMatrix(
        shader::Shader, locIndex::Cint, mat::Matrix)::Cvoid
end

function SetShaderValueTexture(shader, locIndex, texture)
    @ccall libraylib.SetShaderValueTexture(
        shader::Shader, locIndex::Cint, texture::Texture2D)::Cvoid
end

function UnloadShader(shader)
    @ccall libraylib.UnloadShader(shader::Shader)::Cvoid
end

function GetScreenToWorldRayEx(position, camera, width, height)
    @ccall libraylib.GetScreenToWorldRayEx(
        position::Vector2, camera::Camera, width::Cint, height::Cint)::Ray
end

function GetWorldToScreen(position, camera)
    @ccall libraylib.GetWorldToScreen(position::Vector3, camera::Camera)::Vector2
end

function GetWorldToScreenEx(position, camera, width, height)
    @ccall libraylib.GetWorldToScreenEx(
        position::Vector3, camera::Camera, width::Cint, height::Cint)::Vector2
end

function GetWorldToScreen2D(position, camera)
    @ccall libraylib.GetWorldToScreen2D(position::Vector2, camera::Camera2D)::Vector2
end

function GetScreenToWorld2D(position, camera)
    @ccall libraylib.GetScreenToWorld2D(position::Vector2, camera::Camera2D)::Vector2
end

function GetCameraMatrix(camera)
    @ccall libraylib.GetCameraMatrix(camera::Camera)::Matrix
end

function GetCameraMatrix2D(camera)
    @ccall libraylib.GetCameraMatrix2D(camera::Camera2D)::Matrix
end

function SetTargetFPS(fps)
    @ccall libraylib.SetTargetFPS(fps::Cint)::Cvoid
end

function GetFrameTime()
    @ccall libraylib.GetFrameTime()::Cfloat
end

function GetTime()
    @ccall libraylib.GetTime()::Cdouble
end

function GetFPS()
    @ccall libraylib.GetFPS()::Cint
end

function SwapScreenBuffer()
    @ccall libraylib.SwapScreenBuffer()::Cvoid
end

function PollInputEvents()
    @ccall libraylib.PollInputEvents()::Cvoid
end

function WaitTime(seconds)
    @ccall libraylib.WaitTime(seconds::Cdouble)::Cvoid
end

function SetRandomSeed(seed)
    @ccall libraylib.SetRandomSeed(seed::Cuint)::Cvoid
end

function GetRandomValue(min, max)
    @ccall libraylib.GetRandomValue(min::Cint, max::Cint)::Cint
end

function LoadRandomSequence(count, min, max)
    @ccall libraylib.LoadRandomSequence(count::Cuint, min::Cint, max::Cint)::Ptr{Cint}
end

function UnloadRandomSequence(sequence)
    @ccall libraylib.UnloadRandomSequence(sequence::Ptr{Cint})::Cvoid
end

function TakeScreenshot(fileName)
    @ccall libraylib.TakeScreenshot(fileName::Ptr{Cchar})::Cvoid
end

function SetConfigFlags(flags)
    @ccall libraylib.SetConfigFlags(flags::Cuint)::Cvoid
end

function OpenURL(url)
    @ccall libraylib.OpenURL(url::Ptr{Cchar})::Cvoid
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function TraceLog(logLevel, text, va_list...)
    :(@ccall(libraylib.TraceLog(
        logLevel::Cint, text::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
end

function SetTraceLogLevel(logLevel)
    @ccall libraylib.SetTraceLogLevel(logLevel::Cint)::Cvoid
end

function MemAlloc(size)
    @ccall libraylib.MemAlloc(size::Cuint)::Ptr{Cvoid}
end

function MemRealloc(ptr, size)
    @ccall libraylib.MemRealloc(ptr::Ptr{Cvoid}, size::Cuint)::Ptr{Cvoid}
end

function MemFree(ptr)
    @ccall libraylib.MemFree(ptr::Ptr{Cvoid})::Cvoid
end

function SetTraceLogCallback(callback)
    @ccall libraylib.SetTraceLogCallback(callback::TraceLogCallback)::Cvoid
end

function SetLoadFileDataCallback(callback)
    @ccall libraylib.SetLoadFileDataCallback(callback::LoadFileDataCallback)::Cvoid
end

function SetSaveFileDataCallback(callback)
    @ccall libraylib.SetSaveFileDataCallback(callback::SaveFileDataCallback)::Cvoid
end

function SetLoadFileTextCallback(callback)
    @ccall libraylib.SetLoadFileTextCallback(callback::LoadFileTextCallback)::Cvoid
end

function SetSaveFileTextCallback(callback)
    @ccall libraylib.SetSaveFileTextCallback(callback::SaveFileTextCallback)::Cvoid
end

function LoadFileData(fileName, dataSize)
    @ccall libraylib.LoadFileData(fileName::Ptr{Cchar}, dataSize::Ptr{Cint})::Ptr{Cuchar}
end

function UnloadFileData(data)
    @ccall libraylib.UnloadFileData(data::Ptr{Cuchar})::Cvoid
end

function SaveFileData(fileName, data, dataSize)
    @ccall libraylib.SaveFileData(
        fileName::Ptr{Cchar}, data::Ptr{Cvoid}, dataSize::Cint)::Bool
end

function ExportDataAsCode(data, dataSize, fileName)
    @ccall libraylib.ExportDataAsCode(
        data::Ptr{Cuchar}, dataSize::Cint, fileName::Ptr{Cchar})::Bool
end

function LoadFileText(fileName)
    @ccall libraylib.LoadFileText(fileName::Ptr{Cchar})::Ptr{Cchar}
end

function UnloadFileText(text)
    @ccall libraylib.UnloadFileText(text::Ptr{Cchar})::Cvoid
end

function SaveFileText(fileName, text)
    @ccall libraylib.SaveFileText(fileName::Ptr{Cchar}, text::Ptr{Cchar})::Bool
end

function FileExists(fileName)
    @ccall libraylib.FileExists(fileName::Ptr{Cchar})::Bool
end

function DirectoryExists(dirPath)
    @ccall libraylib.DirectoryExists(dirPath::Ptr{Cchar})::Bool
end

function IsFileExtension(fileName, ext)
    @ccall libraylib.IsFileExtension(fileName::Ptr{Cchar}, ext::Ptr{Cchar})::Bool
end

function GetFileLength(fileName)
    @ccall libraylib.GetFileLength(fileName::Ptr{Cchar})::Cint
end

function GetFileExtension(fileName)
    @ccall libraylib.GetFileExtension(fileName::Ptr{Cchar})::Ptr{Cchar}
end

function GetFileName(filePath)
    @ccall libraylib.GetFileName(filePath::Ptr{Cchar})::Ptr{Cchar}
end

function GetFileNameWithoutExt(filePath)
    @ccall libraylib.GetFileNameWithoutExt(filePath::Ptr{Cchar})::Ptr{Cchar}
end

function GetDirectoryPath(filePath)
    @ccall libraylib.GetDirectoryPath(filePath::Ptr{Cchar})::Ptr{Cchar}
end

function GetPrevDirectoryPath(dirPath)
    @ccall libraylib.GetPrevDirectoryPath(dirPath::Ptr{Cchar})::Ptr{Cchar}
end

function GetWorkingDirectory()
    @ccall libraylib.GetWorkingDirectory()::Ptr{Cchar}
end

function GetApplicationDirectory()
    @ccall libraylib.GetApplicationDirectory()::Ptr{Cchar}
end

function MakeDirectory(dirPath)
    @ccall libraylib.MakeDirectory(dirPath::Ptr{Cchar})::Cint
end

function ChangeDirectory(dir)
    @ccall libraylib.ChangeDirectory(dir::Ptr{Cchar})::Bool
end

function IsPathFile(path)
    @ccall libraylib.IsPathFile(path::Ptr{Cchar})::Bool
end

function IsFileNameValid(fileName)
    @ccall libraylib.IsFileNameValid(fileName::Ptr{Cchar})::Bool
end

function LoadDirectoryFiles(dirPath)
    @ccall libraylib.LoadDirectoryFiles(dirPath::Ptr{Cchar})::FilePathList
end

function LoadDirectoryFilesEx(basePath, filter, scanSubdirs)
    @ccall libraylib.LoadDirectoryFilesEx(
        basePath::Ptr{Cchar}, filter::Ptr{Cchar}, scanSubdirs::Bool)::FilePathList
end

function UnloadDirectoryFiles(files)
    @ccall libraylib.UnloadDirectoryFiles(files::FilePathList)::Cvoid
end

function IsFileDropped()
    @ccall libraylib.IsFileDropped()::Bool
end

function LoadDroppedFiles()
    @ccall libraylib.LoadDroppedFiles()::FilePathList
end

function UnloadDroppedFiles(files)
    @ccall libraylib.UnloadDroppedFiles(files::FilePathList)::Cvoid
end

function GetFileModTime(fileName)
    @ccall libraylib.GetFileModTime(fileName::Ptr{Cchar})::Clong
end

function CompressData(data, dataSize, compDataSize)
    @ccall libraylib.CompressData(
        data::Ptr{Cuchar}, dataSize::Cint, compDataSize::Ptr{Cint})::Ptr{Cuchar}
end

function DecompressData(compData, compDataSize, dataSize)
    @ccall libraylib.DecompressData(
        compData::Ptr{Cuchar}, compDataSize::Cint, dataSize::Ptr{Cint})::Ptr{Cuchar}
end

function EncodeDataBase64(data, dataSize, outputSize)
    @ccall libraylib.EncodeDataBase64(
        data::Ptr{Cuchar}, dataSize::Cint, outputSize::Ptr{Cint})::Ptr{Cchar}
end

function DecodeDataBase64(data, outputSize)
    @ccall libraylib.DecodeDataBase64(data::Ptr{Cuchar}, outputSize::Ptr{Cint})::Ptr{Cuchar}
end

function ComputeCRC32(data, dataSize)
    @ccall libraylib.ComputeCRC32(data::Ptr{Cuchar}, dataSize::Cint)::Cuint
end

function ComputeMD5(data, dataSize)
    @ccall libraylib.ComputeMD5(data::Ptr{Cuchar}, dataSize::Cint)::Ptr{Cuint}
end

function ComputeSHA1(data, dataSize)
    @ccall libraylib.ComputeSHA1(data::Ptr{Cuchar}, dataSize::Cint)::Ptr{Cuint}
end

function LoadAutomationEventList(fileName)
    @ccall libraylib.LoadAutomationEventList(fileName::Ptr{Cchar})::AutomationEventList
end

function UnloadAutomationEventList(list)
    @ccall libraylib.UnloadAutomationEventList(list::AutomationEventList)::Cvoid
end

function ExportAutomationEventList(list, fileName)
    @ccall libraylib.ExportAutomationEventList(
        list::AutomationEventList, fileName::Ptr{Cchar})::Bool
end

function SetAutomationEventList(list)
    @ccall libraylib.SetAutomationEventList(list::Ptr{AutomationEventList})::Cvoid
end

function SetAutomationEventBaseFrame(frame)
    @ccall libraylib.SetAutomationEventBaseFrame(frame::Cint)::Cvoid
end

function StartAutomationEventRecording()
    @ccall libraylib.StartAutomationEventRecording()::Cvoid
end

function StopAutomationEventRecording()
    @ccall libraylib.StopAutomationEventRecording()::Cvoid
end

function PlayAutomationEvent(event)
    @ccall libraylib.PlayAutomationEvent(event::AutomationEvent)::Cvoid
end

function IsKeyPressed(key)
    @ccall libraylib.IsKeyPressed(key::Cint)::Bool
end

function IsKeyPressedRepeat(key)
    @ccall libraylib.IsKeyPressedRepeat(key::Cint)::Bool
end

function IsKeyDown(key)
    @ccall libraylib.IsKeyDown(key::Cint)::Bool
end

function IsKeyReleased(key)
    @ccall libraylib.IsKeyReleased(key::Cint)::Bool
end

function IsKeyUp(key)
    @ccall libraylib.IsKeyUp(key::Cint)::Bool
end

function GetKeyPressed()
    @ccall libraylib.GetKeyPressed()::Cint
end

function GetCharPressed()
    @ccall libraylib.GetCharPressed()::Cint
end

function SetExitKey(key)
    @ccall libraylib.SetExitKey(key::Cint)::Cvoid
end

function IsGamepadAvailable(gamepad)
    @ccall libraylib.IsGamepadAvailable(gamepad::Cint)::Bool
end

function GetGamepadName(gamepad)
    @ccall libraylib.GetGamepadName(gamepad::Cint)::Ptr{Cchar}
end

function IsGamepadButtonPressed(gamepad, button)
    @ccall libraylib.IsGamepadButtonPressed(gamepad::Cint, button::Cint)::Bool
end

function IsGamepadButtonDown(gamepad, button)
    @ccall libraylib.IsGamepadButtonDown(gamepad::Cint, button::Cint)::Bool
end

function IsGamepadButtonReleased(gamepad, button)
    @ccall libraylib.IsGamepadButtonReleased(gamepad::Cint, button::Cint)::Bool
end

function IsGamepadButtonUp(gamepad, button)
    @ccall libraylib.IsGamepadButtonUp(gamepad::Cint, button::Cint)::Bool
end

function GetGamepadButtonPressed()
    @ccall libraylib.GetGamepadButtonPressed()::Cint
end

function GetGamepadAxisCount(gamepad)
    @ccall libraylib.GetGamepadAxisCount(gamepad::Cint)::Cint
end

function GetGamepadAxisMovement(gamepad, axis)
    @ccall libraylib.GetGamepadAxisMovement(gamepad::Cint, axis::Cint)::Cfloat
end

function SetGamepadMappings(mappings)
    @ccall libraylib.SetGamepadMappings(mappings::Ptr{Cchar})::Cint
end

function SetGamepadVibration(gamepad, leftMotor, rightMotor, duration)
    @ccall libraylib.SetGamepadVibration(
        gamepad::Cint, leftMotor::Cfloat, rightMotor::Cfloat, duration::Cfloat)::Cvoid
end

function IsMouseButtonPressed(button)
    @ccall libraylib.IsMouseButtonPressed(button::Cint)::Bool
end

function IsMouseButtonDown(button)
    @ccall libraylib.IsMouseButtonDown(button::Cint)::Bool
end

function IsMouseButtonReleased(button)
    @ccall libraylib.IsMouseButtonReleased(button::Cint)::Bool
end

function IsMouseButtonUp(button)
    @ccall libraylib.IsMouseButtonUp(button::Cint)::Bool
end

function GetMouseX()
    @ccall libraylib.GetMouseX()::Cint
end

function GetMouseY()
    @ccall libraylib.GetMouseY()::Cint
end

function GetMousePosition()
    @ccall libraylib.GetMousePosition()::Vector2
end

function GetMouseDelta()
    @ccall libraylib.GetMouseDelta()::Vector2
end

function SetMousePosition(x, y)
    @ccall libraylib.SetMousePosition(x::Cint, y::Cint)::Cvoid
end

function SetMouseOffset(offsetX, offsetY)
    @ccall libraylib.SetMouseOffset(offsetX::Cint, offsetY::Cint)::Cvoid
end

function SetMouseScale(scaleX, scaleY)
    @ccall libraylib.SetMouseScale(scaleX::Cfloat, scaleY::Cfloat)::Cvoid
end

function GetMouseWheelMove()
    @ccall libraylib.GetMouseWheelMove()::Cfloat
end

function GetMouseWheelMoveV()
    @ccall libraylib.GetMouseWheelMoveV()::Vector2
end

function SetMouseCursor(cursor)
    @ccall libraylib.SetMouseCursor(cursor::Cint)::Cvoid
end

function GetTouchX()
    @ccall libraylib.GetTouchX()::Cint
end

function GetTouchY()
    @ccall libraylib.GetTouchY()::Cint
end

function GetTouchPosition(index)
    @ccall libraylib.GetTouchPosition(index::Cint)::Vector2
end

function GetTouchPointId(index)
    @ccall libraylib.GetTouchPointId(index::Cint)::Cint
end

function GetTouchPointCount()
    @ccall libraylib.GetTouchPointCount()::Cint
end

function SetGesturesEnabled(flags)
    @ccall libraylib.SetGesturesEnabled(flags::Cuint)::Cvoid
end

function IsGestureDetected(gesture)
    @ccall libraylib.IsGestureDetected(gesture::Cuint)::Bool
end

function GetGestureDetected()
    @ccall libraylib.GetGestureDetected()::Cint
end

function GetGestureHoldDuration()
    @ccall libraylib.GetGestureHoldDuration()::Cfloat
end

function GetGestureDragVector()
    @ccall libraylib.GetGestureDragVector()::Vector2
end

function GetGestureDragAngle()
    @ccall libraylib.GetGestureDragAngle()::Cfloat
end

function GetGesturePinchVector()
    @ccall libraylib.GetGesturePinchVector()::Vector2
end

function GetGesturePinchAngle()
    @ccall libraylib.GetGesturePinchAngle()::Cfloat
end

function UpdateCamera(camera, mode)
    @ccall libraylib.UpdateCamera(camera::Ptr{Camera}, mode::Cint)::Cvoid
end

function UpdateCameraPro(camera, movement, rotation, zoom)
    @ccall libraylib.UpdateCameraPro(
        camera::Ptr{Camera}, movement::Vector3, rotation::Vector3, zoom::Cfloat)::Cvoid
end

function SetShapesTexture(texture, source)
    @ccall libraylib.SetShapesTexture(texture::Texture2D, source::Rectangle)::Cvoid
end

function GetShapesTexture()
    @ccall libraylib.GetShapesTexture()::Texture2D
end

function GetShapesTextureRectangle()
    @ccall libraylib.GetShapesTextureRectangle()::Rectangle
end

function DrawPixel(posX, posY, color)
    @ccall libraylib.DrawPixel(posX::Cint, posY::Cint, color::Color)::Cvoid
end

function DrawPixelV(position, color)
    @ccall libraylib.DrawPixelV(position::Vector2, color::Color)::Cvoid
end

function DrawLine(startPosX, startPosY, endPosX, endPosY, color)
    @ccall libraylib.DrawLine(
        startPosX::Cint, startPosY::Cint, endPosX::Cint, endPosY::Cint, color::Color)::Cvoid
end

function DrawLineV(startPos, endPos, color)
    @ccall libraylib.DrawLineV(startPos::Vector2, endPos::Vector2, color::Color)::Cvoid
end

function DrawLineEx(startPos, endPos, thick, color)
    @ccall libraylib.DrawLineEx(
        startPos::Vector2, endPos::Vector2, thick::Cfloat, color::Color)::Cvoid
end

function DrawLineStrip(points, pointCount, color)
    @ccall libraylib.DrawLineStrip(
        points::Ptr{Vector2}, pointCount::Cint, color::Color)::Cvoid
end

function DrawLineBezier(startPos, endPos, thick, color)
    @ccall libraylib.DrawLineBezier(
        startPos::Vector2, endPos::Vector2, thick::Cfloat, color::Color)::Cvoid
end

function DrawCircle(centerX, centerY, radius, color)
    @ccall libraylib.DrawCircle(
        centerX::Cint, centerY::Cint, radius::Cfloat, color::Color)::Cvoid
end

function DrawCircleSector(center, radius, startAngle, endAngle, segments, color)
    @ccall libraylib.DrawCircleSector(center::Vector2, radius::Cfloat, startAngle::Cfloat,
        endAngle::Cfloat, segments::Cint, color::Color)::Cvoid
end

function DrawCircleSectorLines(center, radius, startAngle, endAngle, segments, color)
    @ccall libraylib.DrawCircleSectorLines(
        center::Vector2, radius::Cfloat, startAngle::Cfloat,
        endAngle::Cfloat, segments::Cint, color::Color)::Cvoid
end

function DrawCircleGradient(centerX, centerY, radius, inner, outer)
    @ccall libraylib.DrawCircleGradient(
        centerX::Cint, centerY::Cint, radius::Cfloat, inner::Color, outer::Color)::Cvoid
end

function DrawCircleV(center, radius, color)
    @ccall libraylib.DrawCircleV(center::Vector2, radius::Cfloat, color::Color)::Cvoid
end

function DrawCircleLines(centerX, centerY, radius, color)
    @ccall libraylib.DrawCircleLines(
        centerX::Cint, centerY::Cint, radius::Cfloat, color::Color)::Cvoid
end

function DrawCircleLinesV(center, radius, color)
    @ccall libraylib.DrawCircleLinesV(center::Vector2, radius::Cfloat, color::Color)::Cvoid
end

function DrawEllipse(centerX, centerY, radiusH, radiusV, color)
    @ccall libraylib.DrawEllipse(
        centerX::Cint, centerY::Cint, radiusH::Cfloat, radiusV::Cfloat, color::Color)::Cvoid
end

function DrawEllipseLines(centerX, centerY, radiusH, radiusV, color)
    @ccall libraylib.DrawEllipseLines(
        centerX::Cint, centerY::Cint, radiusH::Cfloat, radiusV::Cfloat, color::Color)::Cvoid
end

function DrawRing(center, innerRadius, outerRadius, startAngle, endAngle, segments, color)
    @ccall libraylib.DrawRing(center::Vector2, innerRadius::Cfloat, outerRadius::Cfloat,
        startAngle::Cfloat, endAngle::Cfloat, segments::Cint, color::Color)::Cvoid
end

function DrawRingLines(
    center, innerRadius, outerRadius, startAngle, endAngle, segments, color)
    @ccall libraylib.DrawRingLines(
        center::Vector2, innerRadius::Cfloat, outerRadius::Cfloat,
        startAngle::Cfloat, endAngle::Cfloat, segments::Cint, color::Color)::Cvoid
end

function DrawRectangle(posX, posY, width, height, color)
    @ccall libraylib.DrawRectangle(
        posX::Cint, posY::Cint, width::Cint, height::Cint, color::Color)::Cvoid
end

function DrawRectangleV(position, size, color)
    @ccall libraylib.DrawRectangleV(position::Vector2, size::Vector2, color::Color)::Cvoid
end

function DrawRectangleRec(rec, color)
    @ccall libraylib.DrawRectangleRec(rec::Rectangle, color::Color)::Cvoid
end

function DrawRectanglePro(rec, origin, rotation, color)
    @ccall libraylib.DrawRectanglePro(
        rec::Rectangle, origin::Vector2, rotation::Cfloat, color::Color)::Cvoid
end

function DrawRectangleGradientV(posX, posY, width, height, top, bottom)
    @ccall libraylib.DrawRectangleGradientV(
        posX::Cint, posY::Cint, width::Cint, height::Cint, top::Color, bottom::Color)::Cvoid
end

function DrawRectangleGradientH(posX, posY, width, height, left, right)
    @ccall libraylib.DrawRectangleGradientH(
        posX::Cint, posY::Cint, width::Cint, height::Cint, left::Color, right::Color)::Cvoid
end

function DrawRectangleGradientEx(rec, topLeft, bottomLeft, topRight, bottomRight)
    @ccall libraylib.DrawRectangleGradientEx(
        rec::Rectangle, topLeft::Color, bottomLeft::Color,
        topRight::Color, bottomRight::Color)::Cvoid
end

function DrawRectangleLines(posX, posY, width, height, color)
    @ccall libraylib.DrawRectangleLines(
        posX::Cint, posY::Cint, width::Cint, height::Cint, color::Color)::Cvoid
end

function DrawRectangleLinesEx(rec, lineThick, color)
    @ccall libraylib.DrawRectangleLinesEx(
        rec::Rectangle, lineThick::Cfloat, color::Color)::Cvoid
end

function DrawRectangleRounded(rec, roundness, segments, color)
    @ccall libraylib.DrawRectangleRounded(
        rec::Rectangle, roundness::Cfloat, segments::Cint, color::Color)::Cvoid
end

function DrawRectangleRoundedLines(rec, roundness, segments, color)
    @ccall libraylib.DrawRectangleRoundedLines(
        rec::Rectangle, roundness::Cfloat, segments::Cint, color::Color)::Cvoid
end

function DrawRectangleRoundedLinesEx(rec, roundness, segments, lineThick, color)
    @ccall libraylib.DrawRectangleRoundedLinesEx(
        rec::Rectangle, roundness::Cfloat, segments::Cint,
        lineThick::Cfloat, color::Color)::Cvoid
end

function DrawTriangle(v1, v2, v3, color)
    @ccall libraylib.DrawTriangle(
        v1::Vector2, v2::Vector2, v3::Vector2, color::Color)::Cvoid
end

function DrawTriangleLines(v1, v2, v3, color)
    @ccall libraylib.DrawTriangleLines(
        v1::Vector2, v2::Vector2, v3::Vector2, color::Color)::Cvoid
end

function DrawTriangleFan(points, pointCount, color)
    @ccall libraylib.DrawTriangleFan(
        points::Ptr{Vector2}, pointCount::Cint, color::Color)::Cvoid
end

function DrawTriangleStrip(points, pointCount, color)
    @ccall libraylib.DrawTriangleStrip(
        points::Ptr{Vector2}, pointCount::Cint, color::Color)::Cvoid
end

function DrawPoly(center, sides, radius, rotation, color)
    @ccall libraylib.DrawPoly(
        center::Vector2, sides::Cint, radius::Cfloat, rotation::Cfloat, color::Color)::Cvoid
end

function DrawPolyLines(center, sides, radius, rotation, color)
    @ccall libraylib.DrawPolyLines(
        center::Vector2, sides::Cint, radius::Cfloat, rotation::Cfloat, color::Color)::Cvoid
end

function DrawPolyLinesEx(center, sides, radius, rotation, lineThick, color)
    @ccall libraylib.DrawPolyLinesEx(center::Vector2, sides::Cint, radius::Cfloat,
        rotation::Cfloat, lineThick::Cfloat, color::Color)::Cvoid
end

function DrawSplineLinear(points, pointCount, thick, color)
    @ccall libraylib.DrawSplineLinear(
        points::Ptr{Vector2}, pointCount::Cint, thick::Cfloat, color::Color)::Cvoid
end

function DrawSplineBasis(points, pointCount, thick, color)
    @ccall libraylib.DrawSplineBasis(
        points::Ptr{Vector2}, pointCount::Cint, thick::Cfloat, color::Color)::Cvoid
end

function DrawSplineCatmullRom(points, pointCount, thick, color)
    @ccall libraylib.DrawSplineCatmullRom(
        points::Ptr{Vector2}, pointCount::Cint, thick::Cfloat, color::Color)::Cvoid
end

function DrawSplineBezierQuadratic(points, pointCount, thick, color)
    @ccall libraylib.DrawSplineBezierQuadratic(
        points::Ptr{Vector2}, pointCount::Cint, thick::Cfloat, color::Color)::Cvoid
end

function DrawSplineBezierCubic(points, pointCount, thick, color)
    @ccall libraylib.DrawSplineBezierCubic(
        points::Ptr{Vector2}, pointCount::Cint, thick::Cfloat, color::Color)::Cvoid
end

function DrawSplineSegmentLinear(p1, p2, thick, color)
    @ccall libraylib.DrawSplineSegmentLinear(
        p1::Vector2, p2::Vector2, thick::Cfloat, color::Color)::Cvoid
end

function DrawSplineSegmentBasis(p1, p2, p3, p4, thick, color)
    @ccall libraylib.DrawSplineSegmentBasis(p1::Vector2, p2::Vector2, p3::Vector2,
        p4::Vector2, thick::Cfloat, color::Color)::Cvoid
end

function DrawSplineSegmentCatmullRom(p1, p2, p3, p4, thick, color)
    @ccall libraylib.DrawSplineSegmentCatmullRom(p1::Vector2, p2::Vector2, p3::Vector2,
        p4::Vector2, thick::Cfloat, color::Color)::Cvoid
end

function DrawSplineSegmentBezierQuadratic(p1, c2, p3, thick, color)
    @ccall libraylib.DrawSplineSegmentBezierQuadratic(
        p1::Vector2, c2::Vector2, p3::Vector2, thick::Cfloat, color::Color)::Cvoid
end

function DrawSplineSegmentBezierCubic(p1, c2, c3, p4, thick, color)
    @ccall libraylib.DrawSplineSegmentBezierCubic(p1::Vector2, c2::Vector2, c3::Vector2,
        p4::Vector2, thick::Cfloat, color::Color)::Cvoid
end

function GetSplinePointLinear(startPos, endPos, t)
    @ccall libraylib.GetSplinePointLinear(
        startPos::Vector2, endPos::Vector2, t::Cfloat)::Vector2
end

function GetSplinePointBasis(p1, p2, p3, p4, t)
    @ccall libraylib.GetSplinePointBasis(
        p1::Vector2, p2::Vector2, p3::Vector2, p4::Vector2, t::Cfloat)::Vector2
end

function GetSplinePointCatmullRom(p1, p2, p3, p4, t)
    @ccall libraylib.GetSplinePointCatmullRom(
        p1::Vector2, p2::Vector2, p3::Vector2, p4::Vector2, t::Cfloat)::Vector2
end

function GetSplinePointBezierQuad(p1, c2, p3, t)
    @ccall libraylib.GetSplinePointBezierQuad(
        p1::Vector2, c2::Vector2, p3::Vector2, t::Cfloat)::Vector2
end

function GetSplinePointBezierCubic(p1, c2, c3, p4, t)
    @ccall libraylib.GetSplinePointBezierCubic(
        p1::Vector2, c2::Vector2, c3::Vector2, p4::Vector2, t::Cfloat)::Vector2
end

function CheckCollisionRecs(rec1, rec2)
    @ccall libraylib.CheckCollisionRecs(rec1::Rectangle, rec2::Rectangle)::Bool
end

function CheckCollisionCircles(center1, radius1, center2, radius2)
    @ccall libraylib.CheckCollisionCircles(
        center1::Vector2, radius1::Cfloat, center2::Vector2, radius2::Cfloat)::Bool
end

function CheckCollisionCircleRec(center, radius, rec)
    @ccall libraylib.CheckCollisionCircleRec(
        center::Vector2, radius::Cfloat, rec::Rectangle)::Bool
end

function CheckCollisionCircleLine(center, radius, p1, p2)
    @ccall libraylib.CheckCollisionCircleLine(
        center::Vector2, radius::Cfloat, p1::Vector2, p2::Vector2)::Bool
end

function CheckCollisionPointRec(point, rec)
    @ccall libraylib.CheckCollisionPointRec(point::Vector2, rec::Rectangle)::Bool
end

function CheckCollisionPointCircle(point, center, radius)
    @ccall libraylib.CheckCollisionPointCircle(
        point::Vector2, center::Vector2, radius::Cfloat)::Bool
end

function CheckCollisionPointTriangle(point, p1, p2, p3)
    @ccall libraylib.CheckCollisionPointTriangle(
        point::Vector2, p1::Vector2, p2::Vector2, p3::Vector2)::Bool
end

function CheckCollisionPointLine(point, p1, p2, threshold)
    @ccall libraylib.CheckCollisionPointLine(
        point::Vector2, p1::Vector2, p2::Vector2, threshold::Cint)::Bool
end

function CheckCollisionPointPoly(point, points, pointCount)
    @ccall libraylib.CheckCollisionPointPoly(
        point::Vector2, points::Ptr{Vector2}, pointCount::Cint)::Bool
end

function CheckCollisionLines(startPos1, endPos1, startPos2, endPos2, collisionPoint)
    @ccall libraylib.CheckCollisionLines(
        startPos1::Vector2, endPos1::Vector2, startPos2::Vector2,
        endPos2::Vector2, collisionPoint::Ptr{Vector2})::Bool
end

function GetCollisionRec(rec1, rec2)
    @ccall libraylib.GetCollisionRec(rec1::Rectangle, rec2::Rectangle)::Rectangle
end

function LoadImage(fileName)
    @ccall libraylib.LoadImage(fileName::Ptr{Cchar})::Image
end

function LoadImageRaw(fileName, width, height, format, headerSize)
    @ccall libraylib.LoadImageRaw(fileName::Ptr{Cchar}, width::Cint, height::Cint,
        format::Cint, headerSize::Cint)::Image
end

function LoadImageAnim(fileName, frames)
    @ccall libraylib.LoadImageAnim(fileName::Ptr{Cchar}, frames::Ptr{Cint})::Image
end

function LoadImageAnimFromMemory(fileType, fileData, dataSize, frames)
    @ccall libraylib.LoadImageAnimFromMemory(fileType::Ptr{Cchar}, fileData::Ptr{Cuchar},
        dataSize::Cint, frames::Ptr{Cint})::Image
end

function LoadImageFromMemory(fileType, fileData, dataSize)
    @ccall libraylib.LoadImageFromMemory(
        fileType::Ptr{Cchar}, fileData::Ptr{Cuchar}, dataSize::Cint)::Image
end

function LoadImageFromTexture(texture)
    @ccall libraylib.LoadImageFromTexture(texture::Texture2D)::Image
end

function LoadImageFromScreen()
    @ccall libraylib.LoadImageFromScreen()::Image
end

function IsImageValid(image)
    @ccall libraylib.IsImageValid(image::Image)::Bool
end

function UnloadImage(image)
    @ccall libraylib.UnloadImage(image::Image)::Cvoid
end

function ExportImage(image, fileName)
    @ccall libraylib.ExportImage(image::Image, fileName::Ptr{Cchar})::Bool
end

function ExportImageToMemory(image, fileType, fileSize)
    @ccall libraylib.ExportImageToMemory(
        image::Image, fileType::Ptr{Cchar}, fileSize::Ptr{Cint})::Ptr{Cuchar}
end

function ExportImageAsCode(image, fileName)
    @ccall libraylib.ExportImageAsCode(image::Image, fileName::Ptr{Cchar})::Bool
end

function GenImageColor(width, height, color)
    @ccall libraylib.GenImageColor(width::Cint, height::Cint, color::Color)::Image
end

function GenImageGradientLinear(width, height, direction, start, _end)
    @ccall libraylib.GenImageGradientLinear(
        width::Cint, height::Cint, direction::Cint, start::Color, _end::Color)::Image
end

function GenImageGradientRadial(width, height, density, inner, outer)
    @ccall libraylib.GenImageGradientRadial(
        width::Cint, height::Cint, density::Cfloat, inner::Color, outer::Color)::Image
end

function GenImageGradientSquare(width, height, density, inner, outer)
    @ccall libraylib.GenImageGradientSquare(
        width::Cint, height::Cint, density::Cfloat, inner::Color, outer::Color)::Image
end

function GenImageChecked(width, height, checksX, checksY, col1, col2)
    @ccall libraylib.GenImageChecked(width::Cint, height::Cint, checksX::Cint,
        checksY::Cint, col1::Color, col2::Color)::Image
end

function GenImageWhiteNoise(width, height, factor)
    @ccall libraylib.GenImageWhiteNoise(width::Cint, height::Cint, factor::Cfloat)::Image
end

function GenImagePerlinNoise(width, height, offsetX, offsetY, scale)
    @ccall libraylib.GenImagePerlinNoise(
        width::Cint, height::Cint, offsetX::Cint, offsetY::Cint, scale::Cfloat)::Image
end

function GenImageCellular(width, height, tileSize)
    @ccall libraylib.GenImageCellular(width::Cint, height::Cint, tileSize::Cint)::Image
end

function GenImageText(width, height, text)
    @ccall libraylib.GenImageText(width::Cint, height::Cint, text::Ptr{Cchar})::Image
end

function ImageCopy(image)
    @ccall libraylib.ImageCopy(image::Image)::Image
end

function ImageFromImage(image, rec)
    @ccall libraylib.ImageFromImage(image::Image, rec::Rectangle)::Image
end

function ImageFromChannel(image, selectedChannel)
    @ccall libraylib.ImageFromChannel(image::Image, selectedChannel::Cint)::Image
end

function ImageText(text, fontSize, color)
    @ccall libraylib.ImageText(text::Ptr{Cchar}, fontSize::Cint, color::Color)::Image
end

function ImageTextEx(font, text, fontSize, spacing, tint)
    @ccall libraylib.ImageTextEx(
        font::Font, text::Ptr{Cchar}, fontSize::Cfloat, spacing::Cfloat, tint::Color)::Image
end

function ImageFormat(image, newFormat)
    @ccall libraylib.ImageFormat(image::Ptr{Image}, newFormat::Cint)::Cvoid
end

function ImageToPOT(image, fill)
    @ccall libraylib.ImageToPOT(image::Ptr{Image}, fill::Color)::Cvoid
end

function ImageCrop(image, crop)
    @ccall libraylib.ImageCrop(image::Ptr{Image}, crop::Rectangle)::Cvoid
end

function ImageAlphaCrop(image, threshold)
    @ccall libraylib.ImageAlphaCrop(image::Ptr{Image}, threshold::Cfloat)::Cvoid
end

function ImageAlphaClear(image, color, threshold)
    @ccall libraylib.ImageAlphaClear(
        image::Ptr{Image}, color::Color, threshold::Cfloat)::Cvoid
end

function ImageAlphaMask(image, alphaMask)
    @ccall libraylib.ImageAlphaMask(image::Ptr{Image}, alphaMask::Image)::Cvoid
end

function ImageAlphaPremultiply(image)
    @ccall libraylib.ImageAlphaPremultiply(image::Ptr{Image})::Cvoid
end

function ImageBlurGaussian(image, blurSize)
    @ccall libraylib.ImageBlurGaussian(image::Ptr{Image}, blurSize::Cint)::Cvoid
end

function ImageKernelConvolution(image, kernel, kernelSize)
    @ccall libraylib.ImageKernelConvolution(
        image::Ptr{Image}, kernel::Ptr{Cfloat}, kernelSize::Cint)::Cvoid
end

function ImageResize(image, newWidth, newHeight)
    @ccall libraylib.ImageResize(image::Ptr{Image}, newWidth::Cint, newHeight::Cint)::Cvoid
end

function ImageResizeNN(image, newWidth, newHeight)
    @ccall libraylib.ImageResizeNN(
        image::Ptr{Image}, newWidth::Cint, newHeight::Cint)::Cvoid
end

function ImageResizeCanvas(image, newWidth, newHeight, offsetX, offsetY, fill)
    @ccall libraylib.ImageResizeCanvas(image::Ptr{Image}, newWidth::Cint, newHeight::Cint,
        offsetX::Cint, offsetY::Cint, fill::Color)::Cvoid
end

function ImageMipmaps(image)
    @ccall libraylib.ImageMipmaps(image::Ptr{Image})::Cvoid
end

function ImageDither(image, rBpp, gBpp, bBpp, aBpp)
    @ccall libraylib.ImageDither(
        image::Ptr{Image}, rBpp::Cint, gBpp::Cint, bBpp::Cint, aBpp::Cint)::Cvoid
end

function ImageFlipVertical(image)
    @ccall libraylib.ImageFlipVertical(image::Ptr{Image})::Cvoid
end

function ImageFlipHorizontal(image)
    @ccall libraylib.ImageFlipHorizontal(image::Ptr{Image})::Cvoid
end

function ImageRotate(image, degrees)
    @ccall libraylib.ImageRotate(image::Ptr{Image}, degrees::Cint)::Cvoid
end

function ImageRotateCW(image)
    @ccall libraylib.ImageRotateCW(image::Ptr{Image})::Cvoid
end

function ImageRotateCCW(image)
    @ccall libraylib.ImageRotateCCW(image::Ptr{Image})::Cvoid
end

function ImageColorTint(image, color)
    @ccall libraylib.ImageColorTint(image::Ptr{Image}, color::Color)::Cvoid
end

function ImageColorInvert(image)
    @ccall libraylib.ImageColorInvert(image::Ptr{Image})::Cvoid
end

function ImageColorGrayscale(image)
    @ccall libraylib.ImageColorGrayscale(image::Ptr{Image})::Cvoid
end

function ImageColorContrast(image, contrast)
    @ccall libraylib.ImageColorContrast(image::Ptr{Image}, contrast::Cfloat)::Cvoid
end

function ImageColorBrightness(image, brightness)
    @ccall libraylib.ImageColorBrightness(image::Ptr{Image}, brightness::Cint)::Cvoid
end

function ImageColorReplace(image, color, replace)
    @ccall libraylib.ImageColorReplace(
        image::Ptr{Image}, color::Color, replace::Color)::Cvoid
end

function LoadImageColors(image)
    @ccall libraylib.LoadImageColors(image::Image)::Ptr{Color}
end

function LoadImagePalette(image, maxPaletteSize, colorCount)
    @ccall libraylib.LoadImagePalette(
        image::Image, maxPaletteSize::Cint, colorCount::Ptr{Cint})::Ptr{Color}
end

function UnloadImageColors(colors)
    @ccall libraylib.UnloadImageColors(colors::Ptr{Color})::Cvoid
end

function UnloadImagePalette(colors)
    @ccall libraylib.UnloadImagePalette(colors::Ptr{Color})::Cvoid
end

function GetImageAlphaBorder(image, threshold)
    @ccall libraylib.GetImageAlphaBorder(image::Image, threshold::Cfloat)::Rectangle
end

function GetImageColor(image, x, y)
    @ccall libraylib.GetImageColor(image::Image, x::Cint, y::Cint)::Color
end

function ImageClearBackground(dst, color)
    @ccall libraylib.ImageClearBackground(dst::Ptr{Image}, color::Color)::Cvoid
end

function ImageDrawPixel(dst, posX, posY, color)
    @ccall libraylib.ImageDrawPixel(
        dst::Ptr{Image}, posX::Cint, posY::Cint, color::Color)::Cvoid
end

function ImageDrawPixelV(dst, position, color)
    @ccall libraylib.ImageDrawPixelV(
        dst::Ptr{Image}, position::Vector2, color::Color)::Cvoid
end

function ImageDrawLine(dst, startPosX, startPosY, endPosX, endPosY, color)
    @ccall libraylib.ImageDrawLine(dst::Ptr{Image}, startPosX::Cint, startPosY::Cint,
        endPosX::Cint, endPosY::Cint, color::Color)::Cvoid
end

function ImageDrawLineV(dst, start, _end, color)
    @ccall libraylib.ImageDrawLineV(
        dst::Ptr{Image}, start::Vector2, _end::Vector2, color::Color)::Cvoid
end

function ImageDrawLineEx(dst, start, _end, thick, color)
    @ccall libraylib.ImageDrawLineEx(
        dst::Ptr{Image}, start::Vector2, _end::Vector2, thick::Cint, color::Color)::Cvoid
end

function ImageDrawCircle(dst, centerX, centerY, radius, color)
    @ccall libraylib.ImageDrawCircle(
        dst::Ptr{Image}, centerX::Cint, centerY::Cint, radius::Cint, color::Color)::Cvoid
end

function ImageDrawCircleV(dst, center, radius, color)
    @ccall libraylib.ImageDrawCircleV(
        dst::Ptr{Image}, center::Vector2, radius::Cint, color::Color)::Cvoid
end

function ImageDrawCircleLines(dst, centerX, centerY, radius, color)
    @ccall libraylib.ImageDrawCircleLines(
        dst::Ptr{Image}, centerX::Cint, centerY::Cint, radius::Cint, color::Color)::Cvoid
end

function ImageDrawCircleLinesV(dst, center, radius, color)
    @ccall libraylib.ImageDrawCircleLinesV(
        dst::Ptr{Image}, center::Vector2, radius::Cint, color::Color)::Cvoid
end

function ImageDrawRectangle(dst, posX, posY, width, height, color)
    @ccall libraylib.ImageDrawRectangle(dst::Ptr{Image}, posX::Cint, posY::Cint,
        width::Cint, height::Cint, color::Color)::Cvoid
end

function ImageDrawRectangleV(dst, position, size, color)
    @ccall libraylib.ImageDrawRectangleV(
        dst::Ptr{Image}, position::Vector2, size::Vector2, color::Color)::Cvoid
end

function ImageDrawRectangleRec(dst, rec, color)
    @ccall libraylib.ImageDrawRectangleRec(
        dst::Ptr{Image}, rec::Rectangle, color::Color)::Cvoid
end

function ImageDrawRectangleLines(dst, rec, thick, color)
    @ccall libraylib.ImageDrawRectangleLines(
        dst::Ptr{Image}, rec::Rectangle, thick::Cint, color::Color)::Cvoid
end

function ImageDrawTriangle(dst, v1, v2, v3, color)
    @ccall libraylib.ImageDrawTriangle(
        dst::Ptr{Image}, v1::Vector2, v2::Vector2, v3::Vector2, color::Color)::Cvoid
end

function ImageDrawTriangleEx(dst, v1, v2, v3, c1, c2, c3)
    @ccall libraylib.ImageDrawTriangleEx(dst::Ptr{Image}, v1::Vector2, v2::Vector2,
        v3::Vector2, c1::Color, c2::Color, c3::Color)::Cvoid
end

function ImageDrawTriangleLines(dst, v1, v2, v3, color)
    @ccall libraylib.ImageDrawTriangleLines(
        dst::Ptr{Image}, v1::Vector2, v2::Vector2, v3::Vector2, color::Color)::Cvoid
end

function ImageDrawTriangleFan(dst, points, pointCount, color)
    @ccall libraylib.ImageDrawTriangleFan(
        dst::Ptr{Image}, points::Ptr{Vector2}, pointCount::Cint, color::Color)::Cvoid
end

function ImageDrawTriangleStrip(dst, points, pointCount, color)
    @ccall libraylib.ImageDrawTriangleStrip(
        dst::Ptr{Image}, points::Ptr{Vector2}, pointCount::Cint, color::Color)::Cvoid
end

function ImageDraw(dst, src, srcRec, dstRec, tint)
    @ccall libraylib.ImageDraw(dst::Ptr{Image}, src::Image, srcRec::Rectangle,
        dstRec::Rectangle, tint::Color)::Cvoid
end

function ImageDrawText(dst, text, posX, posY, fontSize, color)
    @ccall libraylib.ImageDrawText(dst::Ptr{Image}, text::Ptr{Cchar}, posX::Cint,
        posY::Cint, fontSize::Cint, color::Color)::Cvoid
end

function ImageDrawTextEx(dst, font, text, position, fontSize, spacing, tint)
    @ccall libraylib.ImageDrawTextEx(
        dst::Ptr{Image}, font::Font, text::Ptr{Cchar}, position::Vector2,
        fontSize::Cfloat, spacing::Cfloat, tint::Color)::Cvoid
end

function LoadTexture(fileName)
    @ccall libraylib.LoadTexture(fileName::Ptr{Cchar})::Texture2D
end

function LoadTextureFromImage(image)
    @ccall libraylib.LoadTextureFromImage(image::Image)::Texture2D
end

function LoadTextureCubemap(image, layout)
    @ccall libraylib.LoadTextureCubemap(image::Image, layout::Cint)::TextureCubemap
end

function LoadRenderTexture(width, height)
    @ccall libraylib.LoadRenderTexture(width::Cint, height::Cint)::RenderTexture2D
end

function IsTextureValid(texture)
    @ccall libraylib.IsTextureValid(texture::Texture2D)::Bool
end

function UnloadTexture(texture)
    @ccall libraylib.UnloadTexture(texture::Texture2D)::Cvoid
end

function IsRenderTextureValid(target)
    @ccall libraylib.IsRenderTextureValid(target::RenderTexture2D)::Bool
end

function UnloadRenderTexture(target)
    @ccall libraylib.UnloadRenderTexture(target::RenderTexture2D)::Cvoid
end

function UpdateTexture(texture, pixels)
    @ccall libraylib.UpdateTexture(texture::Texture2D, pixels::Ptr{Cvoid})::Cvoid
end

function UpdateTextureRec(texture, rec, pixels)
    @ccall libraylib.UpdateTextureRec(
        texture::Texture2D, rec::Rectangle, pixels::Ptr{Cvoid})::Cvoid
end

function GenTextureMipmaps(texture)
    @ccall libraylib.GenTextureMipmaps(texture::Ptr{Texture2D})::Cvoid
end

function SetTextureFilter(texture, filter)
    @ccall libraylib.SetTextureFilter(texture::Texture2D, filter::Cint)::Cvoid
end

function SetTextureWrap(texture, wrap)
    @ccall libraylib.SetTextureWrap(texture::Texture2D, wrap::Cint)::Cvoid
end

function DrawTexture(texture, posX, posY, tint)
    @ccall libraylib.DrawTexture(
        texture::Texture2D, posX::Cint, posY::Cint, tint::Color)::Cvoid
end

function DrawTextureV(texture, position, tint)
    @ccall libraylib.DrawTextureV(texture::Texture2D, position::Vector2, tint::Color)::Cvoid
end

function DrawTextureEx(texture, position, rotation, scale, tint)
    @ccall libraylib.DrawTextureEx(texture::Texture2D, position::Vector2,
        rotation::Cfloat, scale::Cfloat, tint::Color)::Cvoid
end

function DrawTextureRec(texture, source, position, tint)
    @ccall libraylib.DrawTextureRec(
        texture::Texture2D, source::Rectangle, position::Vector2, tint::Color)::Cvoid
end

function DrawTexturePro(texture, source, dest, origin, rotation, tint)
    @ccall libraylib.DrawTexturePro(texture::Texture2D, source::Rectangle, dest::Rectangle,
        origin::Vector2, rotation::Cfloat, tint::Color)::Cvoid
end

function DrawTextureNPatch(texture, nPatchInfo, dest, origin, rotation, tint)
    @ccall libraylib.DrawTextureNPatch(
        texture::Texture2D, nPatchInfo::NPatchInfo, dest::Rectangle,
        origin::Vector2, rotation::Cfloat, tint::Color)::Cvoid
end

function ColorIsEqual(col1, col2)
    @ccall libraylib.ColorIsEqual(col1::Color, col2::Color)::Bool
end

function Fade(color, alpha)
    @ccall libraylib.Fade(color::Color, alpha::Cfloat)::Color
end

function ColorToInt(color)
    @ccall libraylib.ColorToInt(color::Color)::Cint
end

function ColorNormalize(color)
    @ccall libraylib.ColorNormalize(color::Color)::Vector4
end

function ColorFromNormalized(normalized)
    @ccall libraylib.ColorFromNormalized(normalized::Vector4)::Color
end

function ColorToHSV(color)
    @ccall libraylib.ColorToHSV(color::Color)::Vector3
end

function ColorFromHSV(hue, saturation, value)
    @ccall libraylib.ColorFromHSV(hue::Cfloat, saturation::Cfloat, value::Cfloat)::Color
end

function ColorTint(color, tint)
    @ccall libraylib.ColorTint(color::Color, tint::Color)::Color
end

function ColorBrightness(color, factor)
    @ccall libraylib.ColorBrightness(color::Color, factor::Cfloat)::Color
end

function ColorContrast(color, contrast)
    @ccall libraylib.ColorContrast(color::Color, contrast::Cfloat)::Color
end

function ColorAlpha(color, alpha)
    @ccall libraylib.ColorAlpha(color::Color, alpha::Cfloat)::Color
end

function ColorAlphaBlend(dst, src, tint)
    @ccall libraylib.ColorAlphaBlend(dst::Color, src::Color, tint::Color)::Color
end

function ColorLerp(color1, color2, factor)
    @ccall libraylib.ColorLerp(color1::Color, color2::Color, factor::Cfloat)::Color
end

function GetColor(hexValue)
    @ccall libraylib.GetColor(hexValue::Cuint)::Color
end

function GetPixelColor(srcPtr, format)
    @ccall libraylib.GetPixelColor(srcPtr::Ptr{Cvoid}, format::Cint)::Color
end

function SetPixelColor(dstPtr, color, format)
    @ccall libraylib.SetPixelColor(dstPtr::Ptr{Cvoid}, color::Color, format::Cint)::Cvoid
end

function GetPixelDataSize(width, height, format)
    @ccall libraylib.GetPixelDataSize(width::Cint, height::Cint, format::Cint)::Cint
end

function GetFontDefault()
    @ccall libraylib.GetFontDefault()::Font
end

function LoadFont(fileName)
    @ccall libraylib.LoadFont(fileName::Ptr{Cchar})::Font
end

function LoadFontEx(fileName, fontSize, codepoints, codepointCount)
    @ccall libraylib.LoadFontEx(fileName::Ptr{Cchar}, fontSize::Cint,
        codepoints::Ptr{Cint}, codepointCount::Cint)::Font
end

function LoadFontFromImage(image, key, firstChar)
    @ccall libraylib.LoadFontFromImage(image::Image, key::Color, firstChar::Cint)::Font
end

function LoadFontFromMemory(
    fileType, fileData, dataSize, fontSize, codepoints, codepointCount)
    @ccall libraylib.LoadFontFromMemory(
        fileType::Ptr{Cchar}, fileData::Ptr{Cuchar}, dataSize::Cint,
        fontSize::Cint, codepoints::Ptr{Cint}, codepointCount::Cint)::Font
end

function IsFontValid(font)
    @ccall libraylib.IsFontValid(font::Font)::Bool
end

function LoadFontData(fileData, dataSize, fontSize, codepoints, codepointCount, type)
    @ccall libraylib.LoadFontData(fileData::Ptr{Cuchar}, dataSize::Cint, fontSize::Cint,
        codepoints::Ptr{Cint}, codepointCount::Cint, type::Cint)::Ptr{GlyphInfo}
end

function GenImageFontAtlas(glyphs, glyphRecs, glyphCount, fontSize, padding, packMethod)
    @ccall libraylib.GenImageFontAtlas(
        glyphs::Ptr{GlyphInfo}, glyphRecs::Ptr{Ptr{Rectangle}}, glyphCount::Cint,
        fontSize::Cint, padding::Cint, packMethod::Cint)::Image
end

function UnloadFontData(glyphs, glyphCount)
    @ccall libraylib.UnloadFontData(glyphs::Ptr{GlyphInfo}, glyphCount::Cint)::Cvoid
end

function UnloadFont(font)
    @ccall libraylib.UnloadFont(font::Font)::Cvoid
end

function ExportFontAsCode(font, fileName)
    @ccall libraylib.ExportFontAsCode(font::Font, fileName::Ptr{Cchar})::Bool
end

function DrawFPS(posX, posY)
    @ccall libraylib.DrawFPS(posX::Cint, posY::Cint)::Cvoid
end

function DrawText(text, posX, posY, fontSize, color)
    @ccall libraylib.DrawText(
        text::Ptr{Cchar}, posX::Cint, posY::Cint, fontSize::Cint, color::Color)::Cvoid
end

function DrawTextEx(font, text, position, fontSize, spacing, tint)
    @ccall libraylib.DrawTextEx(font::Font, text::Ptr{Cchar}, position::Vector2,
        fontSize::Cfloat, spacing::Cfloat, tint::Color)::Cvoid
end

function DrawTextPro(font, text, position, origin, rotation, fontSize, spacing, tint)
    @ccall libraylib.DrawTextPro(
        font::Font, text::Ptr{Cchar}, position::Vector2, origin::Vector2,
        rotation::Cfloat, fontSize::Cfloat, spacing::Cfloat, tint::Color)::Cvoid
end

function DrawTextCodepoint(font, codepoint, position, fontSize, tint)
    @ccall libraylib.DrawTextCodepoint(font::Font, codepoint::Cint, position::Vector2,
        fontSize::Cfloat, tint::Color)::Cvoid
end

function DrawTextCodepoints(
    font, codepoints, codepointCount, position, fontSize, spacing, tint)
    @ccall libraylib.DrawTextCodepoints(
        font::Font, codepoints::Ptr{Cint}, codepointCount::Cint,
        position::Vector2, fontSize::Cfloat, spacing::Cfloat, tint::Color)::Cvoid
end

function SetTextLineSpacing(spacing)
    @ccall libraylib.SetTextLineSpacing(spacing::Cint)::Cvoid
end

function MeasureText(text, fontSize)
    @ccall libraylib.MeasureText(text::Ptr{Cchar}, fontSize::Cint)::Cint
end

function MeasureTextEx(font, text, fontSize, spacing)
    @ccall libraylib.MeasureTextEx(
        font::Font, text::Ptr{Cchar}, fontSize::Cfloat, spacing::Cfloat)::Vector2
end

function GetGlyphIndex(font, codepoint)
    @ccall libraylib.GetGlyphIndex(font::Font, codepoint::Cint)::Cint
end

function GetGlyphInfo(font, codepoint)
    @ccall libraylib.GetGlyphInfo(font::Font, codepoint::Cint)::GlyphInfo
end

function GetGlyphAtlasRec(font, codepoint)
    @ccall libraylib.GetGlyphAtlasRec(font::Font, codepoint::Cint)::Rectangle
end

function LoadUTF8(codepoints, length)
    @ccall libraylib.LoadUTF8(codepoints::Ptr{Cint}, length::Cint)::Ptr{Cchar}
end

function UnloadUTF8(text)
    @ccall libraylib.UnloadUTF8(text::Ptr{Cchar})::Cvoid
end

function LoadCodepoints(text, count)
    @ccall libraylib.LoadCodepoints(text::Ptr{Cchar}, count::Ptr{Cint})::Ptr{Cint}
end

function UnloadCodepoints(codepoints)
    @ccall libraylib.UnloadCodepoints(codepoints::Ptr{Cint})::Cvoid
end

function GetCodepointCount(text)
    @ccall libraylib.GetCodepointCount(text::Ptr{Cchar})::Cint
end

function GetCodepoint(text, codepointSize)
    @ccall libraylib.GetCodepoint(text::Ptr{Cchar}, codepointSize::Ptr{Cint})::Cint
end

function GetCodepointNext(text, codepointSize)
    @ccall libraylib.GetCodepointNext(text::Ptr{Cchar}, codepointSize::Ptr{Cint})::Cint
end

function GetCodepointPrevious(text, codepointSize)
    @ccall libraylib.GetCodepointPrevious(text::Ptr{Cchar}, codepointSize::Ptr{Cint})::Cint
end

function CodepointToUTF8(codepoint, utf8Size)
    @ccall libraylib.CodepointToUTF8(codepoint::Cint, utf8Size::Ptr{Cint})::Ptr{Cchar}
end

function TextCopy(dst, src)
    @ccall libraylib.TextCopy(dst::Ptr{Cchar}, src::Ptr{Cchar})::Cint
end

function TextIsEqual(text1, text2)
    @ccall libraylib.TextIsEqual(text1::Ptr{Cchar}, text2::Ptr{Cchar})::Bool
end

function TextLength(text)
    @ccall libraylib.TextLength(text::Ptr{Cchar})::Cuint
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function TextFormat(text, va_list...)
    :(@ccall(libraylib.TextFormat(
        text::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Ptr{Cchar}))
end

function TextSubtext(text, position, length)
    @ccall libraylib.TextSubtext(text::Ptr{Cchar}, position::Cint, length::Cint)::Ptr{Cchar}
end

function TextReplace(text, replace, by)
    @ccall libraylib.TextReplace(
        text::Ptr{Cchar}, replace::Ptr{Cchar}, by::Ptr{Cchar})::Ptr{Cchar}
end

function TextInsert(text, insert, position)
    @ccall libraylib.TextInsert(
        text::Ptr{Cchar}, insert::Ptr{Cchar}, position::Cint)::Ptr{Cchar}
end

function TextJoin(textList, count, delimiter)
    @ccall libraylib.TextJoin(
        textList::Ptr{Ptr{Cchar}}, count::Cint, delimiter::Ptr{Cchar})::Ptr{Cchar}
end

function TextSplit(text, delimiter, count)
    @ccall libraylib.TextSplit(
        text::Ptr{Cchar}, delimiter::Cchar, count::Ptr{Cint})::Ptr{Ptr{Cchar}}
end

function TextAppend(text, append, position)
    @ccall libraylib.TextAppend(
        text::Ptr{Cchar}, append::Ptr{Cchar}, position::Ptr{Cint})::Cvoid
end

function TextFindIndex(text, find)
    @ccall libraylib.TextFindIndex(text::Ptr{Cchar}, find::Ptr{Cchar})::Cint
end

function TextToUpper(text)
    @ccall libraylib.TextToUpper(text::Ptr{Cchar})::Ptr{Cchar}
end

function TextToLower(text)
    @ccall libraylib.TextToLower(text::Ptr{Cchar})::Ptr{Cchar}
end

function TextToPascal(text)
    @ccall libraylib.TextToPascal(text::Ptr{Cchar})::Ptr{Cchar}
end

function TextToSnake(text)
    @ccall libraylib.TextToSnake(text::Ptr{Cchar})::Ptr{Cchar}
end

function TextToCamel(text)
    @ccall libraylib.TextToCamel(text::Ptr{Cchar})::Ptr{Cchar}
end

function TextToInteger(text)
    @ccall libraylib.TextToInteger(text::Ptr{Cchar})::Cint
end

function TextToFloat(text)
    @ccall libraylib.TextToFloat(text::Ptr{Cchar})::Cfloat
end

function DrawLine3D(startPos, endPos, color)
    @ccall libraylib.DrawLine3D(startPos::Vector3, endPos::Vector3, color::Color)::Cvoid
end

function DrawPoint3D(position, color)
    @ccall libraylib.DrawPoint3D(position::Vector3, color::Color)::Cvoid
end

function DrawCircle3D(center, radius, rotationAxis, rotationAngle, color)
    @ccall libraylib.DrawCircle3D(center::Vector3, radius::Cfloat, rotationAxis::Vector3,
        rotationAngle::Cfloat, color::Color)::Cvoid
end

function DrawTriangle3D(v1, v2, v3, color)
    @ccall libraylib.DrawTriangle3D(
        v1::Vector3, v2::Vector3, v3::Vector3, color::Color)::Cvoid
end

function DrawTriangleStrip3D(points, pointCount, color)
    @ccall libraylib.DrawTriangleStrip3D(
        points::Ptr{Vector3}, pointCount::Cint, color::Color)::Cvoid
end

function DrawCube(position, width, height, length, color)
    @ccall libraylib.DrawCube(position::Vector3, width::Cfloat, height::Cfloat,
        length::Cfloat, color::Color)::Cvoid
end

function DrawCubeV(position, size, color)
    @ccall libraylib.DrawCubeV(position::Vector3, size::Vector3, color::Color)::Cvoid
end

function DrawCubeWires(position, width, height, length, color)
    @ccall libraylib.DrawCubeWires(position::Vector3, width::Cfloat, height::Cfloat,
        length::Cfloat, color::Color)::Cvoid
end

function DrawCubeWiresV(position, size, color)
    @ccall libraylib.DrawCubeWiresV(position::Vector3, size::Vector3, color::Color)::Cvoid
end

function DrawSphere(centerPos, radius, color)
    @ccall libraylib.DrawSphere(centerPos::Vector3, radius::Cfloat, color::Color)::Cvoid
end

function DrawSphereEx(centerPos, radius, rings, slices, color)
    @ccall libraylib.DrawSphereEx(
        centerPos::Vector3, radius::Cfloat, rings::Cint, slices::Cint, color::Color)::Cvoid
end

function DrawSphereWires(centerPos, radius, rings, slices, color)
    @ccall libraylib.DrawSphereWires(
        centerPos::Vector3, radius::Cfloat, rings::Cint, slices::Cint, color::Color)::Cvoid
end

function DrawCylinder(position, radiusTop, radiusBottom, height, slices, color)
    @ccall libraylib.DrawCylinder(
        position::Vector3, radiusTop::Cfloat, radiusBottom::Cfloat,
        height::Cfloat, slices::Cint, color::Color)::Cvoid
end

function DrawCylinderEx(startPos, endPos, startRadius, endRadius, sides, color)
    @ccall libraylib.DrawCylinderEx(
        startPos::Vector3, endPos::Vector3, startRadius::Cfloat,
        endRadius::Cfloat, sides::Cint, color::Color)::Cvoid
end

function DrawCylinderWires(position, radiusTop, radiusBottom, height, slices, color)
    @ccall libraylib.DrawCylinderWires(
        position::Vector3, radiusTop::Cfloat, radiusBottom::Cfloat,
        height::Cfloat, slices::Cint, color::Color)::Cvoid
end

function DrawCylinderWiresEx(startPos, endPos, startRadius, endRadius, sides, color)
    @ccall libraylib.DrawCylinderWiresEx(
        startPos::Vector3, endPos::Vector3, startRadius::Cfloat,
        endRadius::Cfloat, sides::Cint, color::Color)::Cvoid
end

function DrawCapsule(startPos, endPos, radius, slices, rings, color)
    @ccall libraylib.DrawCapsule(startPos::Vector3, endPos::Vector3, radius::Cfloat,
        slices::Cint, rings::Cint, color::Color)::Cvoid
end

function DrawCapsuleWires(startPos, endPos, radius, slices, rings, color)
    @ccall libraylib.DrawCapsuleWires(startPos::Vector3, endPos::Vector3, radius::Cfloat,
        slices::Cint, rings::Cint, color::Color)::Cvoid
end

function DrawPlane(centerPos, size, color)
    @ccall libraylib.DrawPlane(centerPos::Vector3, size::Vector2, color::Color)::Cvoid
end

function DrawRay(ray, color)
    @ccall libraylib.DrawRay(ray::Ray, color::Color)::Cvoid
end

function DrawGrid(slices, spacing)
    @ccall libraylib.DrawGrid(slices::Cint, spacing::Cfloat)::Cvoid
end

function LoadModel(fileName)
    @ccall libraylib.LoadModel(fileName::Ptr{Cchar})::Model
end

function LoadModelFromMesh(mesh)
    @ccall libraylib.LoadModelFromMesh(mesh::Mesh)::Model
end

function IsModelValid(model)
    @ccall libraylib.IsModelValid(model::Model)::Bool
end

function UnloadModel(model)
    @ccall libraylib.UnloadModel(model::Model)::Cvoid
end

function GetModelBoundingBox(model)
    @ccall libraylib.GetModelBoundingBox(model::Model)::BoundingBox
end

function DrawModel(model, position, scale, tint)
    @ccall libraylib.DrawModel(
        model::Model, position::Vector3, scale::Cfloat, tint::Color)::Cvoid
end

function DrawModelEx(model, position, rotationAxis, rotationAngle, scale, tint)
    @ccall libraylib.DrawModelEx(model::Model, position::Vector3, rotationAxis::Vector3,
        rotationAngle::Cfloat, scale::Vector3, tint::Color)::Cvoid
end

function DrawModelWires(model, position, scale, tint)
    @ccall libraylib.DrawModelWires(
        model::Model, position::Vector3, scale::Cfloat, tint::Color)::Cvoid
end

function DrawModelWiresEx(model, position, rotationAxis, rotationAngle, scale, tint)
    @ccall libraylib.DrawModelWiresEx(
        model::Model, position::Vector3, rotationAxis::Vector3,
        rotationAngle::Cfloat, scale::Vector3, tint::Color)::Cvoid
end

function DrawModelPoints(model, position, scale, tint)
    @ccall libraylib.DrawModelPoints(
        model::Model, position::Vector3, scale::Cfloat, tint::Color)::Cvoid
end

function DrawModelPointsEx(model, position, rotationAxis, rotationAngle, scale, tint)
    @ccall libraylib.DrawModelPointsEx(
        model::Model, position::Vector3, rotationAxis::Vector3,
        rotationAngle::Cfloat, scale::Vector3, tint::Color)::Cvoid
end

function DrawBoundingBox(box, color)
    @ccall libraylib.DrawBoundingBox(box::BoundingBox, color::Color)::Cvoid
end

function DrawBillboard(camera, texture, position, scale, tint)
    @ccall libraylib.DrawBillboard(camera::Camera, texture::Texture2D,
        position::Vector3, scale::Cfloat, tint::Color)::Cvoid
end

function DrawBillboardRec(camera, texture, source, position, size, tint)
    @ccall libraylib.DrawBillboardRec(
        camera::Camera, texture::Texture2D, source::Rectangle,
        position::Vector3, size::Vector2, tint::Color)::Cvoid
end

function DrawBillboardPro(
    camera, texture, source, position, up, size, origin, rotation, tint)
    @ccall libraylib.DrawBillboardPro(
        camera::Camera, texture::Texture2D, source::Rectangle, position::Vector3,
        up::Vector3, size::Vector2, origin::Vector2, rotation::Cfloat, tint::Color)::Cvoid
end

function UploadMesh(mesh, dynamic)
    @ccall libraylib.UploadMesh(mesh::Ptr{Mesh}, dynamic::Bool)::Cvoid
end

function UpdateMeshBuffer(mesh, index, data, dataSize, offset)
    @ccall libraylib.UpdateMeshBuffer(
        mesh::Mesh, index::Cint, data::Ptr{Cvoid}, dataSize::Cint, offset::Cint)::Cvoid
end

function UnloadMesh(mesh)
    @ccall libraylib.UnloadMesh(mesh::Mesh)::Cvoid
end

function DrawMesh(mesh, material, transform)
    @ccall libraylib.DrawMesh(mesh::Mesh, material::Material, transform::Matrix)::Cvoid
end

function DrawMeshInstanced(mesh, material, transforms, instances)
    @ccall libraylib.DrawMeshInstanced(
        mesh::Mesh, material::Material, transforms::Ptr{Matrix}, instances::Cint)::Cvoid
end

function GetMeshBoundingBox(mesh)
    @ccall libraylib.GetMeshBoundingBox(mesh::Mesh)::BoundingBox
end

function GenMeshTangents(mesh)
    @ccall libraylib.GenMeshTangents(mesh::Ptr{Mesh})::Cvoid
end

function ExportMesh(mesh, fileName)
    @ccall libraylib.ExportMesh(mesh::Mesh, fileName::Ptr{Cchar})::Bool
end

function ExportMeshAsCode(mesh, fileName)
    @ccall libraylib.ExportMeshAsCode(mesh::Mesh, fileName::Ptr{Cchar})::Bool
end

function GenMeshPoly(sides, radius)
    @ccall libraylib.GenMeshPoly(sides::Cint, radius::Cfloat)::Mesh
end

function GenMeshPlane(width, length, resX, resZ)
    @ccall libraylib.GenMeshPlane(
        width::Cfloat, length::Cfloat, resX::Cint, resZ::Cint)::Mesh
end

function GenMeshCube(width, height, length)
    @ccall libraylib.GenMeshCube(width::Cfloat, height::Cfloat, length::Cfloat)::Mesh
end

function GenMeshSphere(radius, rings, slices)
    @ccall libraylib.GenMeshSphere(radius::Cfloat, rings::Cint, slices::Cint)::Mesh
end

function GenMeshHemiSphere(radius, rings, slices)
    @ccall libraylib.GenMeshHemiSphere(radius::Cfloat, rings::Cint, slices::Cint)::Mesh
end

function GenMeshCylinder(radius, height, slices)
    @ccall libraylib.GenMeshCylinder(radius::Cfloat, height::Cfloat, slices::Cint)::Mesh
end

function GenMeshCone(radius, height, slices)
    @ccall libraylib.GenMeshCone(radius::Cfloat, height::Cfloat, slices::Cint)::Mesh
end

function GenMeshTorus(radius, size, radSeg, sides)
    @ccall libraylib.GenMeshTorus(
        radius::Cfloat, size::Cfloat, radSeg::Cint, sides::Cint)::Mesh
end

function GenMeshKnot(radius, size, radSeg, sides)
    @ccall libraylib.GenMeshKnot(
        radius::Cfloat, size::Cfloat, radSeg::Cint, sides::Cint)::Mesh
end

function GenMeshHeightmap(heightmap, size)
    @ccall libraylib.GenMeshHeightmap(heightmap::Image, size::Vector3)::Mesh
end

function GenMeshCubicmap(cubicmap, cubeSize)
    @ccall libraylib.GenMeshCubicmap(cubicmap::Image, cubeSize::Vector3)::Mesh
end

function LoadMaterials(fileName, materialCount)
    @ccall libraylib.LoadMaterials(
        fileName::Ptr{Cchar}, materialCount::Ptr{Cint})::Ptr{Material}
end

function LoadMaterialDefault()
    @ccall libraylib.LoadMaterialDefault()::Material
end

function IsMaterialValid(material)
    @ccall libraylib.IsMaterialValid(material::Material)::Bool
end

function UnloadMaterial(material)
    @ccall libraylib.UnloadMaterial(material::Material)::Cvoid
end

function SetMaterialTexture(material, mapType, texture)
    @ccall libraylib.SetMaterialTexture(
        material::Ptr{Material}, mapType::Cint, texture::Texture2D)::Cvoid
end

function SetModelMeshMaterial(model, meshId, materialId)
    @ccall libraylib.SetModelMeshMaterial(
        model::Ptr{Model}, meshId::Cint, materialId::Cint)::Cvoid
end

function LoadModelAnimations(fileName, animCount)
    @ccall libraylib.LoadModelAnimations(
        fileName::Ptr{Cchar}, animCount::Ptr{Cint})::Ptr{ModelAnimation}
end

function UpdateModelAnimation(model, anim, frame)
    @ccall libraylib.UpdateModelAnimation(
        model::Model, anim::ModelAnimation, frame::Cint)::Cvoid
end

function UpdateModelAnimationBones(model, anim, frame)
    @ccall libraylib.UpdateModelAnimationBones(
        model::Model, anim::ModelAnimation, frame::Cint)::Cvoid
end

function UnloadModelAnimation(anim)
    @ccall libraylib.UnloadModelAnimation(anim::ModelAnimation)::Cvoid
end

function UnloadModelAnimations(animations, animCount)
    @ccall libraylib.UnloadModelAnimations(
        animations::Ptr{ModelAnimation}, animCount::Cint)::Cvoid
end

function IsModelAnimationValid(model, anim)
    @ccall libraylib.IsModelAnimationValid(model::Model, anim::ModelAnimation)::Bool
end

function CheckCollisionSpheres(center1, radius1, center2, radius2)
    @ccall libraylib.CheckCollisionSpheres(
        center1::Vector3, radius1::Cfloat, center2::Vector3, radius2::Cfloat)::Bool
end

function CheckCollisionBoxes(box1, box2)
    @ccall libraylib.CheckCollisionBoxes(box1::BoundingBox, box2::BoundingBox)::Bool
end

function CheckCollisionBoxSphere(box, center, radius)
    @ccall libraylib.CheckCollisionBoxSphere(
        box::BoundingBox, center::Vector3, radius::Cfloat)::Bool
end

function GetRayCollisionSphere(ray, center, radius)
    @ccall libraylib.GetRayCollisionSphere(
        ray::Ray, center::Vector3, radius::Cfloat)::RayCollision
end

function GetRayCollisionBox(ray, box)
    @ccall libraylib.GetRayCollisionBox(ray::Ray, box::BoundingBox)::RayCollision
end

function GetRayCollisionMesh(ray, mesh, transform)
    @ccall libraylib.GetRayCollisionMesh(
        ray::Ray, mesh::Mesh, transform::Matrix)::RayCollision
end

function GetRayCollisionTriangle(ray, p1, p2, p3)
    @ccall libraylib.GetRayCollisionTriangle(
        ray::Ray, p1::Vector3, p2::Vector3, p3::Vector3)::RayCollision
end

function GetRayCollisionQuad(ray, p1, p2, p3, p4)
    @ccall libraylib.GetRayCollisionQuad(
        ray::Ray, p1::Vector3, p2::Vector3, p3::Vector3, p4::Vector3)::RayCollision
end

const AudioCallback = Ptr{Cvoid}

function InitAudioDevice()
    @ccall libraylib.InitAudioDevice()::Cvoid
end

function CloseAudioDevice()
    @ccall libraylib.CloseAudioDevice()::Cvoid
end

function IsAudioDeviceReady()
    @ccall libraylib.IsAudioDeviceReady()::Bool
end

function SetMasterVolume(volume)
    @ccall libraylib.SetMasterVolume(volume::Cfloat)::Cvoid
end

function GetMasterVolume()
    @ccall libraylib.GetMasterVolume()::Cfloat
end

function LoadWave(fileName)
    @ccall libraylib.LoadWave(fileName::Ptr{Cchar})::Wave
end

function LoadWaveFromMemory(fileType, fileData, dataSize)
    @ccall libraylib.LoadWaveFromMemory(
        fileType::Ptr{Cchar}, fileData::Ptr{Cuchar}, dataSize::Cint)::Wave
end

function IsWaveValid(wave)
    @ccall libraylib.IsWaveValid(wave::Wave)::Bool
end

function LoadSound(fileName)
    @ccall libraylib.LoadSound(fileName::Ptr{Cchar})::Sound
end

function LoadSoundFromWave(wave)
    @ccall libraylib.LoadSoundFromWave(wave::Wave)::Sound
end

function LoadSoundAlias(source)
    @ccall libraylib.LoadSoundAlias(source::Sound)::Sound
end

function IsSoundValid(sound)
    @ccall libraylib.IsSoundValid(sound::Sound)::Bool
end

function UpdateSound(sound, data, sampleCount)
    @ccall libraylib.UpdateSound(sound::Sound, data::Ptr{Cvoid}, sampleCount::Cint)::Cvoid
end

function UnloadWave(wave)
    @ccall libraylib.UnloadWave(wave::Wave)::Cvoid
end

function UnloadSound(sound)
    @ccall libraylib.UnloadSound(sound::Sound)::Cvoid
end

function UnloadSoundAlias(alias)
    @ccall libraylib.UnloadSoundAlias(alias::Sound)::Cvoid
end

function ExportWave(wave, fileName)
    @ccall libraylib.ExportWave(wave::Wave, fileName::Ptr{Cchar})::Bool
end

function ExportWaveAsCode(wave, fileName)
    @ccall libraylib.ExportWaveAsCode(wave::Wave, fileName::Ptr{Cchar})::Bool
end

function PlaySound(sound)
    @ccall libraylib.PlaySound(sound::Sound)::Cvoid
end

function StopSound(sound)
    @ccall libraylib.StopSound(sound::Sound)::Cvoid
end

function PauseSound(sound)
    @ccall libraylib.PauseSound(sound::Sound)::Cvoid
end

function ResumeSound(sound)
    @ccall libraylib.ResumeSound(sound::Sound)::Cvoid
end

function IsSoundPlaying(sound)
    @ccall libraylib.IsSoundPlaying(sound::Sound)::Bool
end

function SetSoundVolume(sound, volume)
    @ccall libraylib.SetSoundVolume(sound::Sound, volume::Cfloat)::Cvoid
end

function SetSoundPitch(sound, pitch)
    @ccall libraylib.SetSoundPitch(sound::Sound, pitch::Cfloat)::Cvoid
end

function SetSoundPan(sound, pan)
    @ccall libraylib.SetSoundPan(sound::Sound, pan::Cfloat)::Cvoid
end

function WaveCopy(wave)
    @ccall libraylib.WaveCopy(wave::Wave)::Wave
end

function WaveCrop(wave, initFrame, finalFrame)
    @ccall libraylib.WaveCrop(wave::Ptr{Wave}, initFrame::Cint, finalFrame::Cint)::Cvoid
end

function WaveFormat(wave, sampleRate, sampleSize, channels)
    @ccall libraylib.WaveFormat(
        wave::Ptr{Wave}, sampleRate::Cint, sampleSize::Cint, channels::Cint)::Cvoid
end

function LoadWaveSamples(wave)
    @ccall libraylib.LoadWaveSamples(wave::Wave)::Ptr{Cfloat}
end

function UnloadWaveSamples(samples)
    @ccall libraylib.UnloadWaveSamples(samples::Ptr{Cfloat})::Cvoid
end

function LoadMusicStream(fileName)
    @ccall libraylib.LoadMusicStream(fileName::Ptr{Cchar})::Music
end

function LoadMusicStreamFromMemory(fileType, data, dataSize)
    @ccall libraylib.LoadMusicStreamFromMemory(
        fileType::Ptr{Cchar}, data::Ptr{Cuchar}, dataSize::Cint)::Music
end

function IsMusicValid(music)
    @ccall libraylib.IsMusicValid(music::Music)::Bool
end

function UnloadMusicStream(music)
    @ccall libraylib.UnloadMusicStream(music::Music)::Cvoid
end

function PlayMusicStream(music)
    @ccall libraylib.PlayMusicStream(music::Music)::Cvoid
end

function IsMusicStreamPlaying(music)
    @ccall libraylib.IsMusicStreamPlaying(music::Music)::Bool
end

function UpdateMusicStream(music)
    @ccall libraylib.UpdateMusicStream(music::Music)::Cvoid
end

function StopMusicStream(music)
    @ccall libraylib.StopMusicStream(music::Music)::Cvoid
end

function PauseMusicStream(music)
    @ccall libraylib.PauseMusicStream(music::Music)::Cvoid
end

function ResumeMusicStream(music)
    @ccall libraylib.ResumeMusicStream(music::Music)::Cvoid
end

function SeekMusicStream(music, position)
    @ccall libraylib.SeekMusicStream(music::Music, position::Cfloat)::Cvoid
end

function SetMusicVolume(music, volume)
    @ccall libraylib.SetMusicVolume(music::Music, volume::Cfloat)::Cvoid
end

function SetMusicPitch(music, pitch)
    @ccall libraylib.SetMusicPitch(music::Music, pitch::Cfloat)::Cvoid
end

function SetMusicPan(music, pan)
    @ccall libraylib.SetMusicPan(music::Music, pan::Cfloat)::Cvoid
end

function GetMusicTimeLength(music)
    @ccall libraylib.GetMusicTimeLength(music::Music)::Cfloat
end

function GetMusicTimePlayed(music)
    @ccall libraylib.GetMusicTimePlayed(music::Music)::Cfloat
end

function LoadAudioStream(sampleRate, sampleSize, channels)
    @ccall libraylib.LoadAudioStream(
        sampleRate::Cuint, sampleSize::Cuint, channels::Cuint)::AudioStream
end

function IsAudioStreamValid(stream)
    @ccall libraylib.IsAudioStreamValid(stream::AudioStream)::Bool
end

function UnloadAudioStream(stream)
    @ccall libraylib.UnloadAudioStream(stream::AudioStream)::Cvoid
end

function UpdateAudioStream(stream, data, frameCount)
    @ccall libraylib.UpdateAudioStream(
        stream::AudioStream, data::Ptr{Cvoid}, frameCount::Cint)::Cvoid
end

function IsAudioStreamProcessed(stream)
    @ccall libraylib.IsAudioStreamProcessed(stream::AudioStream)::Bool
end

function PlayAudioStream(stream)
    @ccall libraylib.PlayAudioStream(stream::AudioStream)::Cvoid
end

function PauseAudioStream(stream)
    @ccall libraylib.PauseAudioStream(stream::AudioStream)::Cvoid
end

function ResumeAudioStream(stream)
    @ccall libraylib.ResumeAudioStream(stream::AudioStream)::Cvoid
end

function IsAudioStreamPlaying(stream)
    @ccall libraylib.IsAudioStreamPlaying(stream::AudioStream)::Bool
end

function StopAudioStream(stream)
    @ccall libraylib.StopAudioStream(stream::AudioStream)::Cvoid
end

function SetAudioStreamVolume(stream, volume)
    @ccall libraylib.SetAudioStreamVolume(stream::AudioStream, volume::Cfloat)::Cvoid
end

function SetAudioStreamPitch(stream, pitch)
    @ccall libraylib.SetAudioStreamPitch(stream::AudioStream, pitch::Cfloat)::Cvoid
end

function SetAudioStreamPan(stream, pan)
    @ccall libraylib.SetAudioStreamPan(stream::AudioStream, pan::Cfloat)::Cvoid
end

function SetAudioStreamBufferSizeDefault(size)
    @ccall libraylib.SetAudioStreamBufferSizeDefault(size::Cint)::Cvoid
end

function SetAudioStreamCallback(stream, callback)
    @ccall libraylib.SetAudioStreamCallback(
        stream::AudioStream, callback::AudioCallback)::Cvoid
end

function AttachAudioStreamProcessor(stream, processor)
    @ccall libraylib.AttachAudioStreamProcessor(
        stream::AudioStream, processor::AudioCallback)::Cvoid
end

function DetachAudioStreamProcessor(stream, processor)
    @ccall libraylib.DetachAudioStreamProcessor(
        stream::AudioStream, processor::AudioCallback)::Cvoid
end

function AttachAudioMixedProcessor(processor)
    @ccall libraylib.AttachAudioMixedProcessor(processor::AudioCallback)::Cvoid
end

function DetachAudioMixedProcessor(processor)
    @ccall libraylib.DetachAudioMixedProcessor(processor::AudioCallback)::Cvoid
end

struct float16
    v::NTuple{16,Cfloat}
end

function MatrixToFloatV(mat)
    @ccall libraylib.MatrixToFloatV(mat::Matrix)::float16
end

struct float3
    v::NTuple{3,Cfloat}
end

function Vector3ToFloatV(v)
    @ccall libraylib.Vector3ToFloatV(v::Vector3)::float3
end

function Clamp(value, min, max)
    @ccall libraylib.Clamp(value::Cfloat, min::Cfloat, max::Cfloat)::Cfloat
end

function Lerp(start, _end, amount)
    @ccall libraylib.Lerp(start::Cfloat, _end::Cfloat, amount::Cfloat)::Cfloat
end

function Normalize(value, start, _end)
    @ccall libraylib.Normalize(value::Cfloat, start::Cfloat, _end::Cfloat)::Cfloat
end

function Remap(value, inputStart, inputEnd, outputStart, outputEnd)
    @ccall libraylib.Remap(value::Cfloat, inputStart::Cfloat, inputEnd::Cfloat,
        outputStart::Cfloat, outputEnd::Cfloat)::Cfloat
end

function Wrap(value, min, max)
    @ccall libraylib.Wrap(value::Cfloat, min::Cfloat, max::Cfloat)::Cfloat
end

function FloatEquals(x, y)
    @ccall libraylib.FloatEquals(x::Cfloat, y::Cfloat)::Cint
end

function Vector2Zero()
    @ccall libraylib.Vector2Zero()::Vector2
end

function Vector2One()
    @ccall libraylib.Vector2One()::Vector2
end

function Vector2Add(v1, v2)
    @ccall libraylib.Vector2Add(v1::Vector2, v2::Vector2)::Vector2
end

function Vector2AddValue(v, add)
    @ccall libraylib.Vector2AddValue(v::Vector2, add::Cfloat)::Vector2
end

function Vector2Subtract(v1, v2)
    @ccall libraylib.Vector2Subtract(v1::Vector2, v2::Vector2)::Vector2
end

function Vector2SubtractValue(v, sub)
    @ccall libraylib.Vector2SubtractValue(v::Vector2, sub::Cfloat)::Vector2
end

function Vector2Length(v)
    @ccall libraylib.Vector2Length(v::Vector2)::Cfloat
end

function Vector2LengthSqr(v)
    @ccall libraylib.Vector2LengthSqr(v::Vector2)::Cfloat
end

function Vector2DotProduct(v1, v2)
    @ccall libraylib.Vector2DotProduct(v1::Vector2, v2::Vector2)::Cfloat
end

function Vector2Distance(v1, v2)
    @ccall libraylib.Vector2Distance(v1::Vector2, v2::Vector2)::Cfloat
end

function Vector2DistanceSqr(v1, v2)
    @ccall libraylib.Vector2DistanceSqr(v1::Vector2, v2::Vector2)::Cfloat
end

function Vector2Angle(v1, v2)
    @ccall libraylib.Vector2Angle(v1::Vector2, v2::Vector2)::Cfloat
end

function Vector2LineAngle(start, _end)
    @ccall libraylib.Vector2LineAngle(start::Vector2, _end::Vector2)::Cfloat
end

function Vector2Scale(v, scale)
    @ccall libraylib.Vector2Scale(v::Vector2, scale::Cfloat)::Vector2
end

function Vector2Multiply(v1, v2)
    @ccall libraylib.Vector2Multiply(v1::Vector2, v2::Vector2)::Vector2
end

function Vector2Negate(v)
    @ccall libraylib.Vector2Negate(v::Vector2)::Vector2
end

function Vector2Divide(v1, v2)
    @ccall libraylib.Vector2Divide(v1::Vector2, v2::Vector2)::Vector2
end

function Vector2Normalize(v)
    @ccall libraylib.Vector2Normalize(v::Vector2)::Vector2
end

function Vector2Transform(v, mat)
    @ccall libraylib.Vector2Transform(v::Vector2, mat::Matrix)::Vector2
end

function Vector2Lerp(v1, v2, amount)
    @ccall libraylib.Vector2Lerp(v1::Vector2, v2::Vector2, amount::Cfloat)::Vector2
end

function Vector2Reflect(v, normal)
    @ccall libraylib.Vector2Reflect(v::Vector2, normal::Vector2)::Vector2
end

function Vector2Min(v1, v2)
    @ccall libraylib.Vector2Min(v1::Vector2, v2::Vector2)::Vector2
end

function Vector2Max(v1, v2)
    @ccall libraylib.Vector2Max(v1::Vector2, v2::Vector2)::Vector2
end

function Vector2Rotate(v, angle)
    @ccall libraylib.Vector2Rotate(v::Vector2, angle::Cfloat)::Vector2
end

function Vector2MoveTowards(v, target, maxDistance)
    @ccall libraylib.Vector2MoveTowards(
        v::Vector2, target::Vector2, maxDistance::Cfloat)::Vector2
end

function Vector2Invert(v)
    @ccall libraylib.Vector2Invert(v::Vector2)::Vector2
end

function Vector2Clamp(v, min, max)
    @ccall libraylib.Vector2Clamp(v::Vector2, min::Vector2, max::Vector2)::Vector2
end

function Vector2ClampValue(v, min, max)
    @ccall libraylib.Vector2ClampValue(v::Vector2, min::Cfloat, max::Cfloat)::Vector2
end

function Vector2Equals(p, q)
    @ccall libraylib.Vector2Equals(p::Vector2, q::Vector2)::Cint
end

function Vector2Refract(v, n, r)
    @ccall libraylib.Vector2Refract(v::Vector2, n::Vector2, r::Cfloat)::Vector2
end

function Vector3Zero()
    @ccall libraylib.Vector3Zero()::Vector3
end

function Vector3One()
    @ccall libraylib.Vector3One()::Vector3
end

function Vector3Add(v1, v2)
    @ccall libraylib.Vector3Add(v1::Vector3, v2::Vector3)::Vector3
end

function Vector3AddValue(v, add)
    @ccall libraylib.Vector3AddValue(v::Vector3, add::Cfloat)::Vector3
end

function Vector3Subtract(v1, v2)
    @ccall libraylib.Vector3Subtract(v1::Vector3, v2::Vector3)::Vector3
end

function Vector3SubtractValue(v, sub)
    @ccall libraylib.Vector3SubtractValue(v::Vector3, sub::Cfloat)::Vector3
end

function Vector3Scale(v, scalar)
    @ccall libraylib.Vector3Scale(v::Vector3, scalar::Cfloat)::Vector3
end

function Vector3Multiply(v1, v2)
    @ccall libraylib.Vector3Multiply(v1::Vector3, v2::Vector3)::Vector3
end

function Vector3CrossProduct(v1, v2)
    @ccall libraylib.Vector3CrossProduct(v1::Vector3, v2::Vector3)::Vector3
end

function Vector3Perpendicular(v)
    @ccall libraylib.Vector3Perpendicular(v::Vector3)::Vector3
end

function Vector3Length(v)
    @ccall libraylib.Vector3Length(v::Vector3)::Cfloat
end

function Vector3LengthSqr(v)
    @ccall libraylib.Vector3LengthSqr(v::Vector3)::Cfloat
end

function Vector3DotProduct(v1, v2)
    @ccall libraylib.Vector3DotProduct(v1::Vector3, v2::Vector3)::Cfloat
end

function Vector3Distance(v1, v2)
    @ccall libraylib.Vector3Distance(v1::Vector3, v2::Vector3)::Cfloat
end

function Vector3DistanceSqr(v1, v2)
    @ccall libraylib.Vector3DistanceSqr(v1::Vector3, v2::Vector3)::Cfloat
end

function Vector3Angle(v1, v2)
    @ccall libraylib.Vector3Angle(v1::Vector3, v2::Vector3)::Cfloat
end

function Vector3Negate(v)
    @ccall libraylib.Vector3Negate(v::Vector3)::Vector3
end

function Vector3Divide(v1, v2)
    @ccall libraylib.Vector3Divide(v1::Vector3, v2::Vector3)::Vector3
end

function Vector3Normalize(v)
    @ccall libraylib.Vector3Normalize(v::Vector3)::Vector3
end

function Vector3Project(v1, v2)
    @ccall libraylib.Vector3Project(v1::Vector3, v2::Vector3)::Vector3
end

function Vector3Reject(v1, v2)
    @ccall libraylib.Vector3Reject(v1::Vector3, v2::Vector3)::Vector3
end

function Vector3OrthoNormalize(v1, v2)
    @ccall libraylib.Vector3OrthoNormalize(v1::Ptr{Vector3}, v2::Ptr{Vector3})::Cvoid
end

function Vector3Transform(v, mat)
    @ccall libraylib.Vector3Transform(v::Vector3, mat::Matrix)::Vector3
end

function Vector3RotateByQuaternion(v, q)
    @ccall libraylib.Vector3RotateByQuaternion(v::Vector3, q::Quaternion)::Vector3
end

function Vector3RotateByAxisAngle(v, axis, angle)
    @ccall libraylib.Vector3RotateByAxisAngle(
        v::Vector3, axis::Vector3, angle::Cfloat)::Vector3
end

function Vector3MoveTowards(v, target, maxDistance)
    @ccall libraylib.Vector3MoveTowards(
        v::Vector3, target::Vector3, maxDistance::Cfloat)::Vector3
end

function Vector3Lerp(v1, v2, amount)
    @ccall libraylib.Vector3Lerp(v1::Vector3, v2::Vector3, amount::Cfloat)::Vector3
end

function Vector3CubicHermite(v1, tangent1, v2, tangent2, amount)
    @ccall libraylib.Vector3CubicHermite(v1::Vector3, tangent1::Vector3, v2::Vector3,
        tangent2::Vector3, amount::Cfloat)::Vector3
end

function Vector3Reflect(v, normal)
    @ccall libraylib.Vector3Reflect(v::Vector3, normal::Vector3)::Vector3
end

function Vector3Min(v1, v2)
    @ccall libraylib.Vector3Min(v1::Vector3, v2::Vector3)::Vector3
end

function Vector3Max(v1, v2)
    @ccall libraylib.Vector3Max(v1::Vector3, v2::Vector3)::Vector3
end

function Vector3Barycenter(p, a, b, c)
    @ccall libraylib.Vector3Barycenter(
        p::Vector3, a::Vector3, b::Vector3, c::Vector3)::Vector3
end

function Vector3Unproject(source, projection, view)
    @ccall libraylib.Vector3Unproject(
        source::Vector3, projection::Matrix, view::Matrix)::Vector3
end

function Vector3Invert(v)
    @ccall libraylib.Vector3Invert(v::Vector3)::Vector3
end

function Vector3Clamp(v, min, max)
    @ccall libraylib.Vector3Clamp(v::Vector3, min::Vector3, max::Vector3)::Vector3
end

function Vector3ClampValue(v, min, max)
    @ccall libraylib.Vector3ClampValue(v::Vector3, min::Cfloat, max::Cfloat)::Vector3
end

function Vector3Equals(p, q)
    @ccall libraylib.Vector3Equals(p::Vector3, q::Vector3)::Cint
end

function Vector3Refract(v, n, r)
    @ccall libraylib.Vector3Refract(v::Vector3, n::Vector3, r::Cfloat)::Vector3
end

function Vector4Zero()
    @ccall libraylib.Vector4Zero()::Vector4
end

function Vector4One()
    @ccall libraylib.Vector4One()::Vector4
end

function Vector4Add(v1, v2)
    @ccall libraylib.Vector4Add(v1::Vector4, v2::Vector4)::Vector4
end

function Vector4AddValue(v, add)
    @ccall libraylib.Vector4AddValue(v::Vector4, add::Cfloat)::Vector4
end

function Vector4Subtract(v1, v2)
    @ccall libraylib.Vector4Subtract(v1::Vector4, v2::Vector4)::Vector4
end

function Vector4SubtractValue(v, add)
    @ccall libraylib.Vector4SubtractValue(v::Vector4, add::Cfloat)::Vector4
end

function Vector4Length(v)
    @ccall libraylib.Vector4Length(v::Vector4)::Cfloat
end

function Vector4LengthSqr(v)
    @ccall libraylib.Vector4LengthSqr(v::Vector4)::Cfloat
end

function Vector4DotProduct(v1, v2)
    @ccall libraylib.Vector4DotProduct(v1::Vector4, v2::Vector4)::Cfloat
end

function Vector4Distance(v1, v2)
    @ccall libraylib.Vector4Distance(v1::Vector4, v2::Vector4)::Cfloat
end

function Vector4DistanceSqr(v1, v2)
    @ccall libraylib.Vector4DistanceSqr(v1::Vector4, v2::Vector4)::Cfloat
end

function Vector4Scale(v, scale)
    @ccall libraylib.Vector4Scale(v::Vector4, scale::Cfloat)::Vector4
end

function Vector4Multiply(v1, v2)
    @ccall libraylib.Vector4Multiply(v1::Vector4, v2::Vector4)::Vector4
end

function Vector4Negate(v)
    @ccall libraylib.Vector4Negate(v::Vector4)::Vector4
end

function Vector4Divide(v1, v2)
    @ccall libraylib.Vector4Divide(v1::Vector4, v2::Vector4)::Vector4
end

function Vector4Normalize(v)
    @ccall libraylib.Vector4Normalize(v::Vector4)::Vector4
end

function Vector4Min(v1, v2)
    @ccall libraylib.Vector4Min(v1::Vector4, v2::Vector4)::Vector4
end

function Vector4Max(v1, v2)
    @ccall libraylib.Vector4Max(v1::Vector4, v2::Vector4)::Vector4
end

function Vector4Lerp(v1, v2, amount)
    @ccall libraylib.Vector4Lerp(v1::Vector4, v2::Vector4, amount::Cfloat)::Vector4
end

function Vector4MoveTowards(v, target, maxDistance)
    @ccall libraylib.Vector4MoveTowards(
        v::Vector4, target::Vector4, maxDistance::Cfloat)::Vector4
end

function Vector4Invert(v)
    @ccall libraylib.Vector4Invert(v::Vector4)::Vector4
end

function Vector4Equals(p, q)
    @ccall libraylib.Vector4Equals(p::Vector4, q::Vector4)::Cint
end

function MatrixDeterminant(mat)
    @ccall libraylib.MatrixDeterminant(mat::Matrix)::Cfloat
end

function MatrixTrace(mat)
    @ccall libraylib.MatrixTrace(mat::Matrix)::Cfloat
end

function MatrixTranspose(mat)
    @ccall libraylib.MatrixTranspose(mat::Matrix)::Matrix
end

function MatrixInvert(mat)
    @ccall libraylib.MatrixInvert(mat::Matrix)::Matrix
end

function MatrixIdentity()
    @ccall libraylib.MatrixIdentity()::Matrix
end

function MatrixAdd(left, right)
    @ccall libraylib.MatrixAdd(left::Matrix, right::Matrix)::Matrix
end

function MatrixSubtract(left, right)
    @ccall libraylib.MatrixSubtract(left::Matrix, right::Matrix)::Matrix
end

function MatrixMultiply(left, right)
    @ccall libraylib.MatrixMultiply(left::Matrix, right::Matrix)::Matrix
end

function MatrixTranslate(x, y, z)
    @ccall libraylib.MatrixTranslate(x::Cfloat, y::Cfloat, z::Cfloat)::Matrix
end

function MatrixRotate(axis, angle)
    @ccall libraylib.MatrixRotate(axis::Vector3, angle::Cfloat)::Matrix
end

function MatrixRotateX(angle)
    @ccall libraylib.MatrixRotateX(angle::Cfloat)::Matrix
end

function MatrixRotateY(angle)
    @ccall libraylib.MatrixRotateY(angle::Cfloat)::Matrix
end

function MatrixRotateZ(angle)
    @ccall libraylib.MatrixRotateZ(angle::Cfloat)::Matrix
end

function MatrixRotateXYZ(angle)
    @ccall libraylib.MatrixRotateXYZ(angle::Vector3)::Matrix
end

function MatrixRotateZYX(angle)
    @ccall libraylib.MatrixRotateZYX(angle::Vector3)::Matrix
end

function MatrixScale(x, y, z)
    @ccall libraylib.MatrixScale(x::Cfloat, y::Cfloat, z::Cfloat)::Matrix
end

function MatrixFrustum(left, right, bottom, top, nearPlane, farPlane)
    @ccall libraylib.MatrixFrustum(left::Cdouble, right::Cdouble, bottom::Cdouble,
        top::Cdouble, nearPlane::Cdouble, farPlane::Cdouble)::Matrix
end

function MatrixPerspective(fovY, aspect, nearPlane, farPlane)
    @ccall libraylib.MatrixPerspective(
        fovY::Cdouble, aspect::Cdouble, nearPlane::Cdouble, farPlane::Cdouble)::Matrix
end

function MatrixOrtho(left, right, bottom, top, nearPlane, farPlane)
    @ccall libraylib.MatrixOrtho(left::Cdouble, right::Cdouble, bottom::Cdouble,
        top::Cdouble, nearPlane::Cdouble, farPlane::Cdouble)::Matrix
end

function MatrixLookAt(eye, target, up)
    @ccall libraylib.MatrixLookAt(eye::Vector3, target::Vector3, up::Vector3)::Matrix
end

function QuaternionAdd(q1, q2)
    @ccall libraylib.QuaternionAdd(q1::Quaternion, q2::Quaternion)::Quaternion
end

function QuaternionAddValue(q, add)
    @ccall libraylib.QuaternionAddValue(q::Quaternion, add::Cfloat)::Quaternion
end

function QuaternionSubtract(q1, q2)
    @ccall libraylib.QuaternionSubtract(q1::Quaternion, q2::Quaternion)::Quaternion
end

function QuaternionSubtractValue(q, sub)
    @ccall libraylib.QuaternionSubtractValue(q::Quaternion, sub::Cfloat)::Quaternion
end

function QuaternionIdentity()
    @ccall libraylib.QuaternionIdentity()::Quaternion
end

function QuaternionLength(q)
    @ccall libraylib.QuaternionLength(q::Quaternion)::Cfloat
end

function QuaternionNormalize(q)
    @ccall libraylib.QuaternionNormalize(q::Quaternion)::Quaternion
end

function QuaternionInvert(q)
    @ccall libraylib.QuaternionInvert(q::Quaternion)::Quaternion
end

function QuaternionMultiply(q1, q2)
    @ccall libraylib.QuaternionMultiply(q1::Quaternion, q2::Quaternion)::Quaternion
end

function QuaternionScale(q, mul)
    @ccall libraylib.QuaternionScale(q::Quaternion, mul::Cfloat)::Quaternion
end

function QuaternionDivide(q1, q2)
    @ccall libraylib.QuaternionDivide(q1::Quaternion, q2::Quaternion)::Quaternion
end

function QuaternionLerp(q1, q2, amount)
    @ccall libraylib.QuaternionLerp(
        q1::Quaternion, q2::Quaternion, amount::Cfloat)::Quaternion
end

function QuaternionNlerp(q1, q2, amount)
    @ccall libraylib.QuaternionNlerp(
        q1::Quaternion, q2::Quaternion, amount::Cfloat)::Quaternion
end

function QuaternionSlerp(q1, q2, amount)
    @ccall libraylib.QuaternionSlerp(
        q1::Quaternion, q2::Quaternion, amount::Cfloat)::Quaternion
end

function QuaternionCubicHermiteSpline(q1, outTangent1, q2, inTangent2, t)
    @ccall libraylib.QuaternionCubicHermiteSpline(
        q1::Quaternion, outTangent1::Quaternion, q2::Quaternion,
        inTangent2::Quaternion, t::Cfloat)::Quaternion
end

function QuaternionFromVector3ToVector3(from, to)
    @ccall libraylib.QuaternionFromVector3ToVector3(from::Vector3, to::Vector3)::Quaternion
end

function QuaternionFromMatrix(mat)
    @ccall libraylib.QuaternionFromMatrix(mat::Matrix)::Quaternion
end

function QuaternionToMatrix(q)
    @ccall libraylib.QuaternionToMatrix(q::Quaternion)::Matrix
end

function QuaternionFromAxisAngle(axis, angle)
    @ccall libraylib.QuaternionFromAxisAngle(axis::Vector3, angle::Cfloat)::Quaternion
end

function QuaternionToAxisAngle(q, outAxis, outAngle)
    @ccall libraylib.QuaternionToAxisAngle(
        q::Quaternion, outAxis::Ptr{Vector3}, outAngle::Ptr{Cfloat})::Cvoid
end

function QuaternionFromEuler(pitch, yaw, roll)
    @ccall libraylib.QuaternionFromEuler(
        pitch::Cfloat, yaw::Cfloat, roll::Cfloat)::Quaternion
end

function QuaternionToEuler(q)
    @ccall libraylib.QuaternionToEuler(q::Quaternion)::Vector3
end

function QuaternionTransform(q, mat)
    @ccall libraylib.QuaternionTransform(q::Quaternion, mat::Matrix)::Quaternion
end

function QuaternionEquals(p, q)
    @ccall libraylib.QuaternionEquals(p::Quaternion, q::Quaternion)::Cint
end

function MatrixDecompose(mat, translation, rotation, scale)
    @ccall libraylib.MatrixDecompose(mat::Matrix, translation::Ptr{Vector3},
        rotation::Ptr{Quaternion}, scale::Ptr{Vector3})::Cvoid
end

struct rlVertexBuffer
    elementCount::Cint
    vertices::Ptr{Cfloat}
    texcoords::Ptr{Cfloat}
    normals::Ptr{Cfloat}
    colors::Ptr{Cuchar}
    indices::Ptr{Cuint}
    vaoId::Cuint
    vboId::NTuple{5,Cuint}
end

struct rlDrawCall
    mode::Cint
    vertexCount::Cint
    vertexAlignment::Cint
    textureId::Cuint
end

struct rlRenderBatch
    bufferCount::Cint
    currentBuffer::Cint
    vertexBuffer::Ptr{rlVertexBuffer}
    draws::Ptr{rlDrawCall}
    drawCounter::Cint
    currentDepth::Cfloat
end

const rlGlVersion = UInt32
const RL_OPENGL_11::rlGlVersion = 1
const RL_OPENGL_21::rlGlVersion = 2
const RL_OPENGL_33::rlGlVersion = 3
const RL_OPENGL_43::rlGlVersion = 4
const RL_OPENGL_ES_20::rlGlVersion = 5
const RL_OPENGL_ES_30::rlGlVersion = 6

const rlTraceLogLevel = UInt32
const RL_LOG_ALL::rlTraceLogLevel = 0
const RL_LOG_TRACE::rlTraceLogLevel = 1
const RL_LOG_DEBUG::rlTraceLogLevel = 2
const RL_LOG_INFO::rlTraceLogLevel = 3
const RL_LOG_WARNING::rlTraceLogLevel = 4
const RL_LOG_ERROR::rlTraceLogLevel = 5
const RL_LOG_FATAL::rlTraceLogLevel = 6
const RL_LOG_NONE::rlTraceLogLevel = 7

const rlPixelFormat = UInt32
const RL_PIXELFORMAT_UNCOMPRESSED_GRAYSCALE::rlPixelFormat = 1
const RL_PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA::rlPixelFormat = 2
const RL_PIXELFORMAT_UNCOMPRESSED_R5G6B5::rlPixelFormat = 3
const RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8::rlPixelFormat = 4
const RL_PIXELFORMAT_UNCOMPRESSED_R5G5B5A1::rlPixelFormat = 5
const RL_PIXELFORMAT_UNCOMPRESSED_R4G4B4A4::rlPixelFormat = 6
const RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8A8::rlPixelFormat = 7
const RL_PIXELFORMAT_UNCOMPRESSED_R32::rlPixelFormat = 8
const RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32::rlPixelFormat = 9
const RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32A32::rlPixelFormat = 10
const RL_PIXELFORMAT_UNCOMPRESSED_R16::rlPixelFormat = 11
const RL_PIXELFORMAT_UNCOMPRESSED_R16G16B16::rlPixelFormat = 12
const RL_PIXELFORMAT_UNCOMPRESSED_R16G16B16A16::rlPixelFormat = 13
const RL_PIXELFORMAT_COMPRESSED_DXT1_RGB::rlPixelFormat = 14
const RL_PIXELFORMAT_COMPRESSED_DXT1_RGBA::rlPixelFormat = 15
const RL_PIXELFORMAT_COMPRESSED_DXT3_RGBA::rlPixelFormat = 16
const RL_PIXELFORMAT_COMPRESSED_DXT5_RGBA::rlPixelFormat = 17
const RL_PIXELFORMAT_COMPRESSED_ETC1_RGB::rlPixelFormat = 18
const RL_PIXELFORMAT_COMPRESSED_ETC2_RGB::rlPixelFormat = 19
const RL_PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA::rlPixelFormat = 20
const RL_PIXELFORMAT_COMPRESSED_PVRT_RGB::rlPixelFormat = 21
const RL_PIXELFORMAT_COMPRESSED_PVRT_RGBA::rlPixelFormat = 22
const RL_PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA::rlPixelFormat = 23
const RL_PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA::rlPixelFormat = 24

const rlTextureFilter = UInt32
const RL_TEXTURE_FILTER_POINT::rlTextureFilter = 0
const RL_TEXTURE_FILTER_BILINEAR::rlTextureFilter = 1
const RL_TEXTURE_FILTER_TRILINEAR::rlTextureFilter = 2
const RL_TEXTURE_FILTER_ANISOTROPIC_4X::rlTextureFilter = 3
const RL_TEXTURE_FILTER_ANISOTROPIC_8X::rlTextureFilter = 4
const RL_TEXTURE_FILTER_ANISOTROPIC_16X::rlTextureFilter = 5

const rlBlendMode = UInt32
const RL_BLEND_ALPHA::rlBlendMode = 0
const RL_BLEND_ADDITIVE::rlBlendMode = 1
const RL_BLEND_MULTIPLIED::rlBlendMode = 2
const RL_BLEND_ADD_COLORS::rlBlendMode = 3
const RL_BLEND_SUBTRACT_COLORS::rlBlendMode = 4
const RL_BLEND_ALPHA_PREMULTIPLY::rlBlendMode = 5
const RL_BLEND_CUSTOM::rlBlendMode = 6
const RL_BLEND_CUSTOM_SEPARATE::rlBlendMode = 7

const rlShaderLocationIndex = UInt32
const RL_SHADER_LOC_VERTEX_POSITION::rlShaderLocationIndex = 0
const RL_SHADER_LOC_VERTEX_TEXCOORD01::rlShaderLocationIndex = 1
const RL_SHADER_LOC_VERTEX_TEXCOORD02::rlShaderLocationIndex = 2
const RL_SHADER_LOC_VERTEX_NORMAL::rlShaderLocationIndex = 3
const RL_SHADER_LOC_VERTEX_TANGENT::rlShaderLocationIndex = 4
const RL_SHADER_LOC_VERTEX_COLOR::rlShaderLocationIndex = 5
const RL_SHADER_LOC_MATRIX_MVP::rlShaderLocationIndex = 6
const RL_SHADER_LOC_MATRIX_VIEW::rlShaderLocationIndex = 7
const RL_SHADER_LOC_MATRIX_PROJECTION::rlShaderLocationIndex = 8
const RL_SHADER_LOC_MATRIX_MODEL::rlShaderLocationIndex = 9
const RL_SHADER_LOC_MATRIX_NORMAL::rlShaderLocationIndex = 10
const RL_SHADER_LOC_VECTOR_VIEW::rlShaderLocationIndex = 11
const RL_SHADER_LOC_COLOR_DIFFUSE::rlShaderLocationIndex = 12
const RL_SHADER_LOC_COLOR_SPECULAR::rlShaderLocationIndex = 13
const RL_SHADER_LOC_COLOR_AMBIENT::rlShaderLocationIndex = 14
const RL_SHADER_LOC_MAP_ALBEDO::rlShaderLocationIndex = 15
const RL_SHADER_LOC_MAP_METALNESS::rlShaderLocationIndex = 16
const RL_SHADER_LOC_MAP_NORMAL::rlShaderLocationIndex = 17
const RL_SHADER_LOC_MAP_ROUGHNESS::rlShaderLocationIndex = 18
const RL_SHADER_LOC_MAP_OCCLUSION::rlShaderLocationIndex = 19
const RL_SHADER_LOC_MAP_EMISSION::rlShaderLocationIndex = 20
const RL_SHADER_LOC_MAP_HEIGHT::rlShaderLocationIndex = 21
const RL_SHADER_LOC_MAP_CUBEMAP::rlShaderLocationIndex = 22
const RL_SHADER_LOC_MAP_IRRADIANCE::rlShaderLocationIndex = 23
const RL_SHADER_LOC_MAP_PREFILTER::rlShaderLocationIndex = 24
const RL_SHADER_LOC_MAP_BRDF::rlShaderLocationIndex = 25

const rlShaderUniformDataType = UInt32
const RL_SHADER_UNIFORM_FLOAT::rlShaderUniformDataType = 0
const RL_SHADER_UNIFORM_VEC2::rlShaderUniformDataType = 1
const RL_SHADER_UNIFORM_VEC3::rlShaderUniformDataType = 2
const RL_SHADER_UNIFORM_VEC4::rlShaderUniformDataType = 3
const RL_SHADER_UNIFORM_INT::rlShaderUniformDataType = 4
const RL_SHADER_UNIFORM_IVEC2::rlShaderUniformDataType = 5
const RL_SHADER_UNIFORM_IVEC3::rlShaderUniformDataType = 6
const RL_SHADER_UNIFORM_IVEC4::rlShaderUniformDataType = 7
const RL_SHADER_UNIFORM_UINT::rlShaderUniformDataType = 8
const RL_SHADER_UNIFORM_UIVEC2::rlShaderUniformDataType = 9
const RL_SHADER_UNIFORM_UIVEC3::rlShaderUniformDataType = 10
const RL_SHADER_UNIFORM_UIVEC4::rlShaderUniformDataType = 11
const RL_SHADER_UNIFORM_SAMPLER2D::rlShaderUniformDataType = 12

const rlShaderAttributeDataType = UInt32
const RL_SHADER_ATTRIB_FLOAT::rlShaderAttributeDataType = 0
const RL_SHADER_ATTRIB_VEC2::rlShaderAttributeDataType = 1
const RL_SHADER_ATTRIB_VEC3::rlShaderAttributeDataType = 2
const RL_SHADER_ATTRIB_VEC4::rlShaderAttributeDataType = 3

const rlFramebufferAttachType = UInt32
const RL_ATTACHMENT_COLOR_CHANNEL0::rlFramebufferAttachType = 0
const RL_ATTACHMENT_COLOR_CHANNEL1::rlFramebufferAttachType = 1
const RL_ATTACHMENT_COLOR_CHANNEL2::rlFramebufferAttachType = 2
const RL_ATTACHMENT_COLOR_CHANNEL3::rlFramebufferAttachType = 3
const RL_ATTACHMENT_COLOR_CHANNEL4::rlFramebufferAttachType = 4
const RL_ATTACHMENT_COLOR_CHANNEL5::rlFramebufferAttachType = 5
const RL_ATTACHMENT_COLOR_CHANNEL6::rlFramebufferAttachType = 6
const RL_ATTACHMENT_COLOR_CHANNEL7::rlFramebufferAttachType = 7
const RL_ATTACHMENT_DEPTH::rlFramebufferAttachType = 100
const RL_ATTACHMENT_STENCIL::rlFramebufferAttachType = 200

const rlFramebufferAttachTextureType = UInt32
const RL_ATTACHMENT_CUBEMAP_POSITIVE_X::rlFramebufferAttachTextureType = 0
const RL_ATTACHMENT_CUBEMAP_NEGATIVE_X::rlFramebufferAttachTextureType = 1
const RL_ATTACHMENT_CUBEMAP_POSITIVE_Y::rlFramebufferAttachTextureType = 2
const RL_ATTACHMENT_CUBEMAP_NEGATIVE_Y::rlFramebufferAttachTextureType = 3
const RL_ATTACHMENT_CUBEMAP_POSITIVE_Z::rlFramebufferAttachTextureType = 4
const RL_ATTACHMENT_CUBEMAP_NEGATIVE_Z::rlFramebufferAttachTextureType = 5
const RL_ATTACHMENT_TEXTURE2D::rlFramebufferAttachTextureType = 100
const RL_ATTACHMENT_RENDERBUFFER::rlFramebufferAttachTextureType = 200

const rlCullMode = UInt32
const RL_CULL_FACE_FRONT::rlCullMode = 0
const RL_CULL_FACE_BACK::rlCullMode = 1

function rlMatrixMode(mode)
    @ccall libraylib.rlMatrixMode(mode::Cint)::Cvoid
end

function rlPushMatrix()
    @ccall libraylib.rlPushMatrix()::Cvoid
end

function rlPopMatrix()
    @ccall libraylib.rlPopMatrix()::Cvoid
end

function rlLoadIdentity()
    @ccall libraylib.rlLoadIdentity()::Cvoid
end

function rlTranslatef(x, y, z)
    @ccall libraylib.rlTranslatef(x::Cfloat, y::Cfloat, z::Cfloat)::Cvoid
end

function rlRotatef(angle, x, y, z)
    @ccall libraylib.rlRotatef(angle::Cfloat, x::Cfloat, y::Cfloat, z::Cfloat)::Cvoid
end

function rlScalef(x, y, z)
    @ccall libraylib.rlScalef(x::Cfloat, y::Cfloat, z::Cfloat)::Cvoid
end

function rlMultMatrixf(matf)
    @ccall libraylib.rlMultMatrixf(matf::Ptr{Cfloat})::Cvoid
end

function rlFrustum(left, right, bottom, top, znear, zfar)
    @ccall libraylib.rlFrustum(left::Cdouble, right::Cdouble, bottom::Cdouble,
        top::Cdouble, znear::Cdouble, zfar::Cdouble)::Cvoid
end

function rlOrtho(left, right, bottom, top, znear, zfar)
    @ccall libraylib.rlOrtho(left::Cdouble, right::Cdouble, bottom::Cdouble,
        top::Cdouble, znear::Cdouble, zfar::Cdouble)::Cvoid
end

function rlViewport(x, y, width, height)
    @ccall libraylib.rlViewport(x::Cint, y::Cint, width::Cint, height::Cint)::Cvoid
end

function rlSetClipPlanes(nearPlane, farPlane)
    @ccall libraylib.rlSetClipPlanes(nearPlane::Cdouble, farPlane::Cdouble)::Cvoid
end

function rlGetCullDistanceNear()
    @ccall libraylib.rlGetCullDistanceNear()::Cdouble
end

function rlGetCullDistanceFar()
    @ccall libraylib.rlGetCullDistanceFar()::Cdouble
end

function rlBegin(mode)
    @ccall libraylib.rlBegin(mode::Cint)::Cvoid
end

function rlEnd()
    @ccall libraylib.rlEnd()::Cvoid
end

function rlVertex2i(x, y)
    @ccall libraylib.rlVertex2i(x::Cint, y::Cint)::Cvoid
end

function rlVertex2f(x, y)
    @ccall libraylib.rlVertex2f(x::Cfloat, y::Cfloat)::Cvoid
end

function rlVertex3f(x, y, z)
    @ccall libraylib.rlVertex3f(x::Cfloat, y::Cfloat, z::Cfloat)::Cvoid
end

function rlTexCoord2f(x, y)
    @ccall libraylib.rlTexCoord2f(x::Cfloat, y::Cfloat)::Cvoid
end

function rlNormal3f(x, y, z)
    @ccall libraylib.rlNormal3f(x::Cfloat, y::Cfloat, z::Cfloat)::Cvoid
end

function rlColor4ub(r, g, b, a)
    @ccall libraylib.rlColor4ub(r::Cuchar, g::Cuchar, b::Cuchar, a::Cuchar)::Cvoid
end

function rlColor3f(x, y, z)
    @ccall libraylib.rlColor3f(x::Cfloat, y::Cfloat, z::Cfloat)::Cvoid
end

function rlColor4f(x, y, z, w)
    @ccall libraylib.rlColor4f(x::Cfloat, y::Cfloat, z::Cfloat, w::Cfloat)::Cvoid
end

function rlEnableVertexArray(vaoId)
    @ccall libraylib.rlEnableVertexArray(vaoId::Cuint)::Bool
end

function rlDisableVertexArray()
    @ccall libraylib.rlDisableVertexArray()::Cvoid
end

function rlEnableVertexBuffer(id)
    @ccall libraylib.rlEnableVertexBuffer(id::Cuint)::Cvoid
end

function rlDisableVertexBuffer()
    @ccall libraylib.rlDisableVertexBuffer()::Cvoid
end

function rlEnableVertexBufferElement(id)
    @ccall libraylib.rlEnableVertexBufferElement(id::Cuint)::Cvoid
end

function rlDisableVertexBufferElement()
    @ccall libraylib.rlDisableVertexBufferElement()::Cvoid
end

function rlEnableVertexAttribute(index)
    @ccall libraylib.rlEnableVertexAttribute(index::Cuint)::Cvoid
end

function rlDisableVertexAttribute(index)
    @ccall libraylib.rlDisableVertexAttribute(index::Cuint)::Cvoid
end

function rlActiveTextureSlot(slot)
    @ccall libraylib.rlActiveTextureSlot(slot::Cint)::Cvoid
end

function rlEnableTexture(id)
    @ccall libraylib.rlEnableTexture(id::Cuint)::Cvoid
end

function rlDisableTexture()
    @ccall libraylib.rlDisableTexture()::Cvoid
end

function rlEnableTextureCubemap(id)
    @ccall libraylib.rlEnableTextureCubemap(id::Cuint)::Cvoid
end

function rlDisableTextureCubemap()
    @ccall libraylib.rlDisableTextureCubemap()::Cvoid
end

function rlTextureParameters(id, param, value)
    @ccall libraylib.rlTextureParameters(id::Cuint, param::Cint, value::Cint)::Cvoid
end

function rlCubemapParameters(id, param, value)
    @ccall libraylib.rlCubemapParameters(id::Cuint, param::Cint, value::Cint)::Cvoid
end

function rlEnableShader(id)
    @ccall libraylib.rlEnableShader(id::Cuint)::Cvoid
end

function rlDisableShader()
    @ccall libraylib.rlDisableShader()::Cvoid
end

function rlEnableFramebuffer(id)
    @ccall libraylib.rlEnableFramebuffer(id::Cuint)::Cvoid
end

function rlDisableFramebuffer()
    @ccall libraylib.rlDisableFramebuffer()::Cvoid
end

function rlGetActiveFramebuffer()
    @ccall libraylib.rlGetActiveFramebuffer()::Cuint
end

function rlActiveDrawBuffers(count)
    @ccall libraylib.rlActiveDrawBuffers(count::Cint)::Cvoid
end

function rlBlitFramebuffer(
    srcX, srcY, srcWidth, srcHeight, dstX, dstY, dstWidth, dstHeight, bufferMask)
    @ccall libraylib.rlBlitFramebuffer(
        srcX::Cint, srcY::Cint, srcWidth::Cint, srcHeight::Cint, dstX::Cint,
        dstY::Cint, dstWidth::Cint, dstHeight::Cint, bufferMask::Cint)::Cvoid
end

function rlBindFramebuffer(target, framebuffer)
    @ccall libraylib.rlBindFramebuffer(target::Cuint, framebuffer::Cuint)::Cvoid
end

function rlEnableColorBlend()
    @ccall libraylib.rlEnableColorBlend()::Cvoid
end

function rlDisableColorBlend()
    @ccall libraylib.rlDisableColorBlend()::Cvoid
end

function rlEnableDepthTest()
    @ccall libraylib.rlEnableDepthTest()::Cvoid
end

function rlDisableDepthTest()
    @ccall libraylib.rlDisableDepthTest()::Cvoid
end

function rlEnableDepthMask()
    @ccall libraylib.rlEnableDepthMask()::Cvoid
end

function rlDisableDepthMask()
    @ccall libraylib.rlDisableDepthMask()::Cvoid
end

function rlEnableBackfaceCulling()
    @ccall libraylib.rlEnableBackfaceCulling()::Cvoid
end

function rlDisableBackfaceCulling()
    @ccall libraylib.rlDisableBackfaceCulling()::Cvoid
end

function rlColorMask(r, g, b, a)
    @ccall libraylib.rlColorMask(r::Bool, g::Bool, b::Bool, a::Bool)::Cvoid
end

function rlSetCullFace(mode)
    @ccall libraylib.rlSetCullFace(mode::Cint)::Cvoid
end

function rlEnableScissorTest()
    @ccall libraylib.rlEnableScissorTest()::Cvoid
end

function rlDisableScissorTest()
    @ccall libraylib.rlDisableScissorTest()::Cvoid
end

function rlScissor(x, y, width, height)
    @ccall libraylib.rlScissor(x::Cint, y::Cint, width::Cint, height::Cint)::Cvoid
end

function rlEnableWireMode()
    @ccall libraylib.rlEnableWireMode()::Cvoid
end

function rlEnablePointMode()
    @ccall libraylib.rlEnablePointMode()::Cvoid
end

function rlDisableWireMode()
    @ccall libraylib.rlDisableWireMode()::Cvoid
end

function rlSetLineWidth(width)
    @ccall libraylib.rlSetLineWidth(width::Cfloat)::Cvoid
end

function rlGetLineWidth()
    @ccall libraylib.rlGetLineWidth()::Cfloat
end

function rlEnableSmoothLines()
    @ccall libraylib.rlEnableSmoothLines()::Cvoid
end

function rlDisableSmoothLines()
    @ccall libraylib.rlDisableSmoothLines()::Cvoid
end

function rlEnableStereoRender()
    @ccall libraylib.rlEnableStereoRender()::Cvoid
end

function rlDisableStereoRender()
    @ccall libraylib.rlDisableStereoRender()::Cvoid
end

function rlIsStereoRenderEnabled()
    @ccall libraylib.rlIsStereoRenderEnabled()::Bool
end

function rlClearColor(r, g, b, a)
    @ccall libraylib.rlClearColor(r::Cuchar, g::Cuchar, b::Cuchar, a::Cuchar)::Cvoid
end

function rlClearScreenBuffers()
    @ccall libraylib.rlClearScreenBuffers()::Cvoid
end

function rlCheckErrors()
    @ccall libraylib.rlCheckErrors()::Cvoid
end

function rlSetBlendMode(mode)
    @ccall libraylib.rlSetBlendMode(mode::Cint)::Cvoid
end

function rlSetBlendFactors(glSrcFactor, glDstFactor, glEquation)
    @ccall libraylib.rlSetBlendFactors(
        glSrcFactor::Cint, glDstFactor::Cint, glEquation::Cint)::Cvoid
end

function rlSetBlendFactorsSeparate(
    glSrcRGB, glDstRGB, glSrcAlpha, glDstAlpha, glEqRGB, glEqAlpha)
    @ccall libraylib.rlSetBlendFactorsSeparate(
        glSrcRGB::Cint, glDstRGB::Cint, glSrcAlpha::Cint,
        glDstAlpha::Cint, glEqRGB::Cint, glEqAlpha::Cint)::Cvoid
end

function rlglInit(width, height)
    @ccall libraylib.rlglInit(width::Cint, height::Cint)::Cvoid
end

function rlglClose()
    @ccall libraylib.rlglClose()::Cvoid
end

function rlLoadExtensions(loader)
    @ccall libraylib.rlLoadExtensions(loader::Ptr{Cvoid})::Cvoid
end

function rlGetVersion()
    @ccall libraylib.rlGetVersion()::Cint
end

function rlSetFramebufferWidth(width)
    @ccall libraylib.rlSetFramebufferWidth(width::Cint)::Cvoid
end

function rlGetFramebufferWidth()
    @ccall libraylib.rlGetFramebufferWidth()::Cint
end

function rlSetFramebufferHeight(height)
    @ccall libraylib.rlSetFramebufferHeight(height::Cint)::Cvoid
end

function rlGetFramebufferHeight()
    @ccall libraylib.rlGetFramebufferHeight()::Cint
end

function rlGetTextureIdDefault()
    @ccall libraylib.rlGetTextureIdDefault()::Cuint
end

function rlGetShaderIdDefault()
    @ccall libraylib.rlGetShaderIdDefault()::Cuint
end

function rlGetShaderLocsDefault()
    @ccall libraylib.rlGetShaderLocsDefault()::Ptr{Cint}
end

function rlLoadRenderBatch(numBuffers, bufferElements)
    @ccall libraylib.rlLoadRenderBatch(
        numBuffers::Cint, bufferElements::Cint)::rlRenderBatch
end

function rlUnloadRenderBatch(batch)
    @ccall libraylib.rlUnloadRenderBatch(batch::rlRenderBatch)::Cvoid
end

function rlDrawRenderBatch(batch)
    @ccall libraylib.rlDrawRenderBatch(batch::Ptr{rlRenderBatch})::Cvoid
end

function rlSetRenderBatchActive(batch)
    @ccall libraylib.rlSetRenderBatchActive(batch::Ptr{rlRenderBatch})::Cvoid
end

function rlDrawRenderBatchActive()
    @ccall libraylib.rlDrawRenderBatchActive()::Cvoid
end

function rlCheckRenderBatchLimit(vCount)
    @ccall libraylib.rlCheckRenderBatchLimit(vCount::Cint)::Bool
end

function rlSetTexture(id)
    @ccall libraylib.rlSetTexture(id::Cuint)::Cvoid
end

function rlLoadVertexArray()
    @ccall libraylib.rlLoadVertexArray()::Cuint
end

function rlLoadVertexBuffer(buffer, size, dynamic)
    @ccall libraylib.rlLoadVertexBuffer(
        buffer::Ptr{Cvoid}, size::Cint, dynamic::Bool)::Cuint
end

function rlLoadVertexBufferElement(buffer, size, dynamic)
    @ccall libraylib.rlLoadVertexBufferElement(
        buffer::Ptr{Cvoid}, size::Cint, dynamic::Bool)::Cuint
end

function rlUpdateVertexBuffer(bufferId, data, dataSize, offset)
    @ccall libraylib.rlUpdateVertexBuffer(
        bufferId::Cuint, data::Ptr{Cvoid}, dataSize::Cint, offset::Cint)::Cvoid
end

function rlUpdateVertexBufferElements(id, data, dataSize, offset)
    @ccall libraylib.rlUpdateVertexBufferElements(
        id::Cuint, data::Ptr{Cvoid}, dataSize::Cint, offset::Cint)::Cvoid
end

function rlUnloadVertexArray(vaoId)
    @ccall libraylib.rlUnloadVertexArray(vaoId::Cuint)::Cvoid
end

function rlUnloadVertexBuffer(vboId)
    @ccall libraylib.rlUnloadVertexBuffer(vboId::Cuint)::Cvoid
end

function rlSetVertexAttribute(index, compSize, type, normalized, stride, offset)
    @ccall libraylib.rlSetVertexAttribute(index::Cuint, compSize::Cint, type::Cint,
        normalized::Bool, stride::Cint, offset::Cint)::Cvoid
end

function rlSetVertexAttributeDivisor(index, divisor)
    @ccall libraylib.rlSetVertexAttributeDivisor(index::Cuint, divisor::Cint)::Cvoid
end

function rlSetVertexAttributeDefault(locIndex, value, attribType, count)
    @ccall libraylib.rlSetVertexAttributeDefault(
        locIndex::Cint, value::Ptr{Cvoid}, attribType::Cint, count::Cint)::Cvoid
end

function rlDrawVertexArray(offset, count)
    @ccall libraylib.rlDrawVertexArray(offset::Cint, count::Cint)::Cvoid
end

function rlDrawVertexArrayElements(offset, count, buffer)
    @ccall libraylib.rlDrawVertexArrayElements(
        offset::Cint, count::Cint, buffer::Ptr{Cvoid})::Cvoid
end

function rlDrawVertexArrayInstanced(offset, count, instances)
    @ccall libraylib.rlDrawVertexArrayInstanced(
        offset::Cint, count::Cint, instances::Cint)::Cvoid
end

function rlDrawVertexArrayElementsInstanced(offset, count, buffer, instances)
    @ccall libraylib.rlDrawVertexArrayElementsInstanced(
        offset::Cint, count::Cint, buffer::Ptr{Cvoid}, instances::Cint)::Cvoid
end

function rlLoadTexture(data, width, height, format, mipmapCount)
    @ccall libraylib.rlLoadTexture(
        data::Ptr{Cvoid}, width::Cint, height::Cint, format::Cint, mipmapCount::Cint)::Cuint
end

function rlLoadTextureDepth(width, height, useRenderBuffer)
    @ccall libraylib.rlLoadTextureDepth(
        width::Cint, height::Cint, useRenderBuffer::Bool)::Cuint
end

function rlLoadTextureCubemap(data, size, format, mipmapCount)
    @ccall libraylib.rlLoadTextureCubemap(
        data::Ptr{Cvoid}, size::Cint, format::Cint, mipmapCount::Cint)::Cuint
end

function rlUpdateTexture(id, offsetX, offsetY, width, height, format, data)
    @ccall libraylib.rlUpdateTexture(id::Cuint, offsetX::Cint, offsetY::Cint, width::Cint,
        height::Cint, format::Cint, data::Ptr{Cvoid})::Cvoid
end

function rlGetGlTextureFormats(format, glInternalFormat, glFormat, glType)
    @ccall libraylib.rlGetGlTextureFormats(format::Cint, glInternalFormat::Ptr{Cuint},
        glFormat::Ptr{Cuint}, glType::Ptr{Cuint})::Cvoid
end

function rlGetPixelFormatName(format)
    @ccall libraylib.rlGetPixelFormatName(format::Cuint)::Ptr{Cchar}
end

function rlUnloadTexture(id)
    @ccall libraylib.rlUnloadTexture(id::Cuint)::Cvoid
end

function rlGenTextureMipmaps(id, width, height, format, mipmaps)
    @ccall libraylib.rlGenTextureMipmaps(
        id::Cuint, width::Cint, height::Cint, format::Cint, mipmaps::Ptr{Cint})::Cvoid
end

function rlReadTexturePixels(id, width, height, format)
    @ccall libraylib.rlReadTexturePixels(
        id::Cuint, width::Cint, height::Cint, format::Cint)::Ptr{Cvoid}
end

function rlReadScreenPixels(width, height)
    @ccall libraylib.rlReadScreenPixels(width::Cint, height::Cint)::Ptr{Cuchar}
end

function rlLoadFramebuffer()
    @ccall libraylib.rlLoadFramebuffer()::Cuint
end

function rlFramebufferAttach(fboId, texId, attachType, texType, mipLevel)
    @ccall libraylib.rlFramebufferAttach(
        fboId::Cuint, texId::Cuint, attachType::Cint, texType::Cint, mipLevel::Cint)::Cvoid
end

function rlFramebufferComplete(id)
    @ccall libraylib.rlFramebufferComplete(id::Cuint)::Bool
end

function rlUnloadFramebuffer(id)
    @ccall libraylib.rlUnloadFramebuffer(id::Cuint)::Cvoid
end

function rlLoadShaderCode(vsCode, fsCode)
    @ccall libraylib.rlLoadShaderCode(vsCode::Ptr{Cchar}, fsCode::Ptr{Cchar})::Cuint
end

function rlCompileShader(shaderCode, type)
    @ccall libraylib.rlCompileShader(shaderCode::Ptr{Cchar}, type::Cint)::Cuint
end

function rlLoadShaderProgram(vShaderId, fShaderId)
    @ccall libraylib.rlLoadShaderProgram(vShaderId::Cuint, fShaderId::Cuint)::Cuint
end

function rlUnloadShaderProgram(id)
    @ccall libraylib.rlUnloadShaderProgram(id::Cuint)::Cvoid
end

function rlGetLocationUniform(shaderId, uniformName)
    @ccall libraylib.rlGetLocationUniform(shaderId::Cuint, uniformName::Ptr{Cchar})::Cint
end

function rlGetLocationAttrib(shaderId, attribName)
    @ccall libraylib.rlGetLocationAttrib(shaderId::Cuint, attribName::Ptr{Cchar})::Cint
end

function rlSetUniform(locIndex, value, uniformType, count)
    @ccall libraylib.rlSetUniform(
        locIndex::Cint, value::Ptr{Cvoid}, uniformType::Cint, count::Cint)::Cvoid
end

function rlSetUniformMatrix(locIndex, mat)
    @ccall libraylib.rlSetUniformMatrix(locIndex::Cint, mat::Matrix)::Cvoid
end

function rlSetUniformMatrices(locIndex, mat, count)
    @ccall libraylib.rlSetUniformMatrices(
        locIndex::Cint, mat::Ptr{Matrix}, count::Cint)::Cvoid
end

function rlSetUniformSampler(locIndex, textureId)
    @ccall libraylib.rlSetUniformSampler(locIndex::Cint, textureId::Cuint)::Cvoid
end

function rlSetShader(id, locs)
    @ccall libraylib.rlSetShader(id::Cuint, locs::Ptr{Cint})::Cvoid
end

function rlLoadComputeShaderProgram(shaderId)
    @ccall libraylib.rlLoadComputeShaderProgram(shaderId::Cuint)::Cuint
end

function rlComputeShaderDispatch(groupX, groupY, groupZ)
    @ccall libraylib.rlComputeShaderDispatch(
        groupX::Cuint, groupY::Cuint, groupZ::Cuint)::Cvoid
end

function rlLoadShaderBuffer(size, data, usageHint)
    @ccall libraylib.rlLoadShaderBuffer(
        size::Cuint, data::Ptr{Cvoid}, usageHint::Cint)::Cuint
end

function rlUnloadShaderBuffer(ssboId)
    @ccall libraylib.rlUnloadShaderBuffer(ssboId::Cuint)::Cvoid
end

function rlUpdateShaderBuffer(id, data, dataSize, offset)
    @ccall libraylib.rlUpdateShaderBuffer(
        id::Cuint, data::Ptr{Cvoid}, dataSize::Cuint, offset::Cuint)::Cvoid
end

function rlBindShaderBuffer(id, index)
    @ccall libraylib.rlBindShaderBuffer(id::Cuint, index::Cuint)::Cvoid
end

function rlReadShaderBuffer(id, dest, count, offset)
    @ccall libraylib.rlReadShaderBuffer(
        id::Cuint, dest::Ptr{Cvoid}, count::Cuint, offset::Cuint)::Cvoid
end

function rlCopyShaderBuffer(destId, srcId, destOffset, srcOffset, count)
    @ccall libraylib.rlCopyShaderBuffer(destId::Cuint, srcId::Cuint, destOffset::Cuint,
        srcOffset::Cuint, count::Cuint)::Cvoid
end

function rlGetShaderBufferSize(id)
    @ccall libraylib.rlGetShaderBufferSize(id::Cuint)::Cuint
end

function rlBindImageTexture(id, index, format, readonly)
    @ccall libraylib.rlBindImageTexture(
        id::Cuint, index::Cuint, format::Cint, readonly::Bool)::Cvoid
end

function rlGetMatrixModelview()
    @ccall libraylib.rlGetMatrixModelview()::Matrix
end

function rlGetMatrixProjection()
    @ccall libraylib.rlGetMatrixProjection()::Matrix
end

function rlGetMatrixTransform()
    @ccall libraylib.rlGetMatrixTransform()::Matrix
end

function rlGetMatrixProjectionStereo(eye)
    @ccall libraylib.rlGetMatrixProjectionStereo(eye::Cint)::Matrix
end

function rlGetMatrixViewOffsetStereo(eye)
    @ccall libraylib.rlGetMatrixViewOffsetStereo(eye::Cint)::Matrix
end

function rlSetMatrixProjection(proj)
    @ccall libraylib.rlSetMatrixProjection(proj::Matrix)::Cvoid
end

function rlSetMatrixModelview(view)
    @ccall libraylib.rlSetMatrixModelview(view::Matrix)::Cvoid
end

function rlSetMatrixProjectionStereo(right, left)
    @ccall libraylib.rlSetMatrixProjectionStereo(right::Matrix, left::Matrix)::Cvoid
end

function rlSetMatrixViewOffsetStereo(right, left)
    @ccall libraylib.rlSetMatrixViewOffsetStereo(right::Matrix, left::Matrix)::Cvoid
end

function rlLoadDrawCube()
    @ccall libraylib.rlLoadDrawCube()::Cvoid
end

function rlLoadDrawQuad()
    @ccall libraylib.rlLoadDrawQuad()::Cvoid
end

const RAYLIB_VERSION_MAJOR = 5

const RAYLIB_VERSION_MINOR = 5

const RAYLIB_VERSION_PATCH = 0

const RAYLIB_VERSION = "5.5"

const RLAPI = nothing

const PI = Float32(3.141592653589793)
export PI

const DEG2RAD = PI ÷ Float32(180.0)
export DEG2RAD

const RAD2DEG = Float32(180.0) ÷ PI
export RAD2DEG

const RL_COLOR_TYPE = nothing

const RL_RECTANGLE_TYPE = nothing

const RL_VECTOR2_TYPE = nothing

const RL_VECTOR3_TYPE = nothing

const RL_VECTOR4_TYPE = nothing

const RL_QUATERNION_TYPE = nothing

const RL_MATRIX_TYPE = nothing

const LIGHTGRAY = Color(200, 200, 200, 255)
export LIGHTGRAY

const GRAY = Color(130, 130, 130, 255)
export GRAY

const DARKGRAY = Color(80, 80, 80, 255)
export DARKGRAY

const YELLOW = Color(253, 249, 0, 255)
export YELLOW

const GOLD = Color(255, 203, 0, 255)
export GOLD

const ORANGE = Color(255, 161, 0, 255)
export ORANGE

const PINK = Color(255, 109, 194, 255)
export PINK

const RED = Color(230, 41, 55, 255)
export RED

const MAROON = Color(190, 33, 55, 255)
export MAROON

const GREEN = Color(0, 228, 48, 255)
export GREEN

const LIME = Color(0, 158, 47, 255)
export LIME

const DARKGREEN = Color(0, 117, 44, 255)
export DARKGREEN

const SKYBLUE = Color(102, 191, 255, 255)
export SKYBLUE

const BLUE = Color(0, 121, 241, 255)
export BLUE

const DARKBLUE = Color(0, 82, 172, 255)
export DARKBLUE

const PURPLE = Color(200, 122, 255, 255)
export PURPLE

const VIOLET = Color(135, 60, 190, 255)
export VIOLET

const DARKPURPLE = Color(112, 31, 126, 255)
export DARKPURPLE

const BEIGE = Color(211, 176, 131, 255)
export BEIGE

const BROWN = Color(127, 106, 79, 255)
export BROWN

const DARKBROWN = Color(76, 63, 47, 255)
export DARKBROWN

const WHITE = Color(255, 255, 255, 255)
export WHITE

const BLACK = Color(0, 0, 0, 255)
export BLACK

const BLANK = Color(0, 0, 0, 0)
export BLANK

const MAGENTA = Color(255, 0, 255, 255)
export MAGENTA

const RAYWHITE = Color(245, 245, 245, 255)
export RAYWHITE

const MOUSE_LEFT_BUTTON = MOUSE_BUTTON_LEFT

const MOUSE_RIGHT_BUTTON = MOUSE_BUTTON_RIGHT

const MOUSE_MIDDLE_BUTTON = MOUSE_BUTTON_MIDDLE

const MATERIAL_MAP_DIFFUSE = MATERIAL_MAP_ALBEDO

const MATERIAL_MAP_SPECULAR = MATERIAL_MAP_METALNESS

const SHADER_LOC_MAP_DIFFUSE = SHADER_LOC_MAP_ALBEDO

const SHADER_LOC_MAP_SPECULAR = SHADER_LOC_MAP_METALNESS

const GetMouseRay = GetScreenToWorldRay

# Skipping MacroDefinition: RMAPI inline

const EPSILON = Float32(1.0e-6)

const RLGL_VERSION = "5.0"

const GRAPHICS_API_OPENGL_33 = nothing

const RLGL_RENDER_TEXTURES_HINT = nothing

const RL_DEFAULT_BATCH_BUFFER_ELEMENTS = 8192

const RL_DEFAULT_BATCH_BUFFERS = 1

const RL_DEFAULT_BATCH_DRAWCALLS = 256

const RL_DEFAULT_BATCH_MAX_TEXTURE_UNITS = 4

const RL_MAX_MATRIX_STACK_SIZE = 32

const RL_MAX_SHADER_LOCATIONS = 32

const RL_CULL_DISTANCE_NEAR = 0.01

const RL_CULL_DISTANCE_FAR = 1000.0

const RL_TEXTURE_WRAP_S = 0x2802

const RL_TEXTURE_WRAP_T = 0x2803

const RL_TEXTURE_MAG_FILTER = 0x2800

const RL_TEXTURE_MIN_FILTER = 0x2801

const RL_TEXTURE_FILTER_NEAREST = 0x2600

const RL_TEXTURE_FILTER_LINEAR = 0x2601

const RL_TEXTURE_FILTER_MIP_NEAREST = 0x2700

const RL_TEXTURE_FILTER_NEAREST_MIP_LINEAR = 0x2702

const RL_TEXTURE_FILTER_LINEAR_MIP_NEAREST = 0x2701

const RL_TEXTURE_FILTER_MIP_LINEAR = 0x2703

const RL_TEXTURE_FILTER_ANISOTROPIC = 0x3000

const RL_TEXTURE_MIPMAP_BIAS_RATIO = 0x4000

const RL_TEXTURE_WRAP_REPEAT = 0x2901

const RL_TEXTURE_WRAP_CLAMP = 0x812f

const RL_TEXTURE_WRAP_MIRROR_REPEAT = 0x8370

const RL_TEXTURE_WRAP_MIRROR_CLAMP = 0x8742

const RL_MODELVIEW = 0x1700

const RL_PROJECTION = 0x1701

const RL_TEXTURE = 0x1702

const RL_LINES = 0x0001

const RL_TRIANGLES = 0x0004

const RL_QUADS = 0x0007

const RL_UNSIGNED_BYTE = 0x1401

const RL_FLOAT = 0x1406

const RL_STREAM_DRAW = 0x88e0

const RL_STREAM_READ = 0x88e1

const RL_STREAM_COPY = 0x88e2

const RL_STATIC_DRAW = 0x88e4

const RL_STATIC_READ = 0x88e5

const RL_STATIC_COPY = 0x88e6

const RL_DYNAMIC_DRAW = 0x88e8

const RL_DYNAMIC_READ = 0x88e9

const RL_DYNAMIC_COPY = 0x88ea

const RL_FRAGMENT_SHADER = 0x8b30

const RL_VERTEX_SHADER = 0x8b31

const RL_COMPUTE_SHADER = 0x91b9

const RL_ZERO = 0

const RL_ONE = 1

const RL_SRC_COLOR = 0x0300

const RL_ONE_MINUS_SRC_COLOR = 0x0301

const RL_SRC_ALPHA = 0x0302

const RL_ONE_MINUS_SRC_ALPHA = 0x0303

const RL_DST_ALPHA = 0x0304

const RL_ONE_MINUS_DST_ALPHA = 0x0305

const RL_DST_COLOR = 0x0306

const RL_ONE_MINUS_DST_COLOR = 0x0307

const RL_SRC_ALPHA_SATURATE = 0x0308

const RL_CONSTANT_COLOR = 0x8001

const RL_ONE_MINUS_CONSTANT_COLOR = 0x8002

const RL_CONSTANT_ALPHA = 0x8003

const RL_ONE_MINUS_CONSTANT_ALPHA = 0x8004

const RL_FUNC_ADD = 0x8006

const RL_MIN = 0x8007

const RL_MAX = 0x8008

const RL_FUNC_SUBTRACT = 0x800a

const RL_FUNC_REVERSE_SUBTRACT = 0x800b

const RL_BLEND_EQUATION = 0x8009

const RL_BLEND_EQUATION_RGB = 0x8009

const RL_BLEND_EQUATION_ALPHA = 0x883d

const RL_BLEND_DST_RGB = 0x80c8

const RL_BLEND_SRC_RGB = 0x80c9

const RL_BLEND_DST_ALPHA = 0x80ca

const RL_BLEND_SRC_ALPHA = 0x80cb

const RL_BLEND_COLOR = 0x8005

const RL_READ_FRAMEBUFFER = 0x8ca8

const RL_DRAW_FRAMEBUFFER = 0x8ca9

const RL_DEFAULT_SHADER_ATTRIB_LOCATION_POSITION = 0

const RL_DEFAULT_SHADER_ATTRIB_LOCATION_TEXCOORD = 1

const RL_DEFAULT_SHADER_ATTRIB_LOCATION_NORMAL = 2

const RL_DEFAULT_SHADER_ATTRIB_LOCATION_COLOR = 3

const RL_DEFAULT_SHADER_ATTRIB_LOCATION_TANGENT = 4

const RL_DEFAULT_SHADER_ATTRIB_LOCATION_TEXCOORD2 = 5

const RL_DEFAULT_SHADER_ATTRIB_LOCATION_INDICES = 6

const RL_SHADER_LOC_MAP_DIFFUSE = RL_SHADER_LOC_MAP_ALBEDO

const RL_SHADER_LOC_MAP_SPECULAR = RL_SHADER_LOC_MAP_METALNESS

# exports
for name in names(@__MODULE__; all=true)
    if name == :eval || name == :include || contains(string(name), "#")
        continue
    end
    @eval export $name
end
