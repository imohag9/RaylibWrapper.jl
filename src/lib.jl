using Libdl
using LazyArtifacts
using ZipArchives: ZipReader, zip_readentry, zip_names
using Downloads: download
using Pkg.Artifacts

function create_structure(paths::Vector{String}, arti_path::String, archive)
    for path in paths
        rel_path = joinpath(arti_path, path)
        if endswith(path, "/")
            if !isdir(rel_path)
                mkpath(rel_path)

            end
        else

            data = zip_readentry(archive, path)
            open(rel_path, "w") do io
                write(io, data)
            end

        end
    end
end


libraylib = if Sys.iswindows()

    artifact_toml = joinpath(@__DIR__, "Artifacts.toml");


    raylib_win_hash = artifact_hash("RaylibWindows", artifact_toml);


    if raylib_win_hash == nothing || !artifact_exists(raylib_win_hash)

        raylib_win_hash = create_artifact() do artifact_dir


            download("https://github.com/raysan5/raylib/releases/download/5.5/raylib-5.5_win64_msvc16.zip", joinpath(artifact_dir, "raylib_win"));
        end

        bind_artifact!(artifact_toml, "RaylibWindows", raylib_win_hash; force=true);
    end

    raylib_win_path = artifact_path(raylib_win_hash);
    data = read(joinpath(raylib_win_path, "raylib_win"));

    archive = ZipReader(data);
    create_structure(zip_names(archive), raylib_win_path, archive);

    rm(joinpath(raylib_win_path, "raylib_win"));

    joinpath(raylib_win_path, "raylib-5.5_win64_msvc16",
        "lib", "raylib." * Libdl.dlext)


elseif Sys.isapple()
    joinpath(LazyArtifacts.artifact"raylib-macos", "raylib-5.5_macos",
        "lib", "libraylib." * Libdl.dlext)

else
    joinpath(LazyArtifacts.artifact"raylib-linux", "raylib-5.5_linux_amd64",
        "lib", "libraylib." * Libdl.dlext)

end

export libraylib


