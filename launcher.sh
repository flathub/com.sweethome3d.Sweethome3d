#!/bin/sh

if grep -q org.freedesktop.Platform.GL.nvidia /.flatpak-info ; then
	exec /app/lib/sweethome3d/SweetHome3D-Java3D-1_5_2 "$@"
else
	MESA_GL_VERSION_OVERRIDE=1.4 exec /app/lib/sweethome3d/SweetHome3D "$@"
fi
