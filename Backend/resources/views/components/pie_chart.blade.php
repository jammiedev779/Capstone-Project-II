<x-filament::section>
    <div id="pie_chart"></div>
</x-filament::section>

<?php
    $super_admin = $this->user->is_superadmin;
    $data_set = [];
    if ($super_admin) {
        $data_set = [
            count($this->admin_data['active_patients']),
            count($this->admin_data['inactive_patients']),
        ];
    } else {
        $data_set = [
            count($this->hospital_data['upcomming_appointments']),
            count($this->hospital_data['ongoing_appointments']),
            count($this->hospital_data['completed_appointments']),
        ];
    }
?>
@push('scripts')
    <script>
        var data_set = {!! json_encode($data_set) !!};
        var super_admin = {!! json_encode($super_admin) !!};

        var options = {
            chart: {
                height: 350,
                type: "donut",
            },
            series: data_set,
            labels: super_admin ? ['Active', 'Inactive'] : ['Upcomming', 'Ongoing', "Completed"],
        };

        var chart = new ApexCharts(document.querySelector("#pie_chart"), options);

        chart.render();
    </script>
@endpush
