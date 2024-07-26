<?php

namespace App\Services;

class PanelService
{
    public static function get_panel_group()
    {
        return
            [
                // 'Dashboard'             => ['Dashboards'],
                'Appointment'           => ['Appointments'],
                'Patient'               => ['Patients'],
                'User and Privilege'    => ['Admins', 'Roles', 'Permissions'],
                'Setting'               => ['Hospitals', 'Specialists', 'Departments', 'Categories']
            ];
    }
    public static function get_panel_order($model)
    {

        $panel_groups = [
            0   => 'Appointment',
            10  => 'Patient',
            20  => 'User and Privilege',
            30  => 'Setting',
        ];

        $panels = [
            0   => ['Appointment'],
            10  => ['Patient'],
            20  => ['Admin', 'Role', 'Permission'],
            30  => ['Hospital', 'Specialist', 'Department', 'Category']
        ];

        $get_panel_group = 0;
        $get_panel = [];

        foreach ($panels as $key => $panel) {
            $found = false;
            foreach ($panel as $index => $item) {
                if ($model == $item) {
                    $found = true;
                    $get_panel_group = $key;
                    $get_panel['sort'] = $key + $index;
                    break;
                }
            }
            if ($found == true) break;
        }

        foreach ($panel_groups as $key_index => $panel_group) {
            if ($get_panel_group == $key_index) {
                $get_panel['group_name'] = $panel_group;
            }
        }

        return $get_panel;
    }
}
