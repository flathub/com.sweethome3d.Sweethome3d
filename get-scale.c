/*
 * Copyright (C) 2022 Bastien Nocera <hadess@hadess.net>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 *
 * Gets the first monitor's scaling factor using GTK3.
 */

#include <gtk/gtk.h>

int main (int argc, char **argv)
{
	GdkDisplay *display;
	GListModel *monitors;
	GdkMonitor *monitor;
	guint scale = 1;

	gtk_init (&argc, &argv);

	display = gdk_display_get_default ();
	if (!display)
		goto out;

	monitor = gdk_display_get_monitor (display, 0);
	if (!monitor)
		goto out;

	scale = gdk_monitor_get_scale_factor (monitor);

out:
	g_print ("%d", scale);
	return 0;
}
