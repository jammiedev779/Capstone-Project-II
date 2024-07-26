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
                'Doctor'                => ['Doctors'],
                'User and Privilege'    => ['Admins', 'Roles', 'Permissions'],
                'Setting'               => ['Hospitals', 'Specialists', 'Departments', 'Categories']
            ];
    }
    public static function get_panel_order($model)
    {

        $panel_groups = [
            0   => 'Appointment',
            10  => 'Patient',
            20  => 'Doctor',
            30  => 'User and Privilege',
            40  => 'Setting',
        ];

        $panels = [
            0   => ['Appointment'],
            10  => ['Patient'],
            20  => ['Doctor'],
            30  => ['Admin', 'Role', 'Permission'],
            40  => ['Hospital', 'Specialist', 'Department', 'Category']
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

    public static function get_panel_icon($model)
    {
        $panel_icons = [
            'Appointment' => 'heroicon-o-rectangle-stack',
            'Patient' => 'heroicon-o-rectangle-stack',
            'Doctor' => 'heroicon-o-rectangle-stack',
            'Admin' => 'heroicon-o-rectangle-stack',
            'Role' => 'heroicon-o-rectangle-stack',
            'Permission' => 'heroicon-o-rectangle-stack',
            'HospitalDetail' => 'heroicon-o-rectangle-stack',
            'Specialist' => 'heroicon-o-rectangle-stack',
            'Department' => 'heroicon-o-rectangle-stack',
            'Category' => 'heroicon-o-rectangle-stack',
        ];

        return $panel_icons[$model];
    }
}
