<x-filament::section>
    <x-slot name="heading">
        @if($this->user->is_superadmin)
            Hospitals and Patients
        @else
            Appointments
        @endif
    </x-slot>
    <div id="line_chart"></div>
</x-filament::section>

<?php
    $super_admin = $this->user->is_superadmin;
    $monthly_data1 = array_fill(0, 12, 0);
    $monthly_data2 = array_fill(0, 12, 0);
    if($this->user->is_superadmin){
        foreach ($this->admin_data['hospitals'] as $item) {
            $month = Carbon\Carbon::parse($item->created_at)->month;
            $monthly_data1[$month - 1] += 1;
        }
        foreach ($this->admin_data['patients'] as $item) {
            $month = Carbon\Carbon::parse($item->created_at)->month;
            $monthly_data2[$month - 1] += 1;
        }
    }else{
        foreach ($this->hospital_data['upcomming_appointments'] as $item) {
            $month = Carbon\Carbon::parse($item->created_at)->month;
            $monthly_data1[$month - 1] += 1;
        }
        foreach ($this->hospital_data['ongoing_appointments'] as $item) {
            $month = Carbon\Carbon::parse($item->created_at)->month;
            $monthly_data2[$month - 1] += 1;
        }
    }
?>

@push('scripts')
    <script>

        var data_set1 = {!! json_encode($monthly_data1) !!};
        var data_set2 = {!! json_encode($monthly_data2) !!};
        var super_admin = {!! json_encode($super_admin) !!};

        var options = {
            chart: {
                height: 350,
                type: "line",
                stacked: false
            },
            dataLabels: {
                enabled: false
            },
            colors: ["#FF1654", "#247BA0"],
            series: [{
                    name: super_admin ? "Hospitals" : "Upcomming",
                    data: data_set1
                },
                {
                    name: super_admin ? "Patients" : "Ongoing",
                    data: data_set2
                }
            ],
            stroke: {
                width: [4, 4]
            },
            plotOptions: {
                bar: {
                    columnWidth: "20%"
                }
            },
            xaxis: {
                categories: months
            },
            yaxis: [{
                    axisTicks: {
                        show: true
                    },
                    axisBorder: {
                        show: true,
                        color: "#FF1654"
                    },
                    labels: {
                        style: {
                            colors: "#FF1654"
                        }
                    },
                    title: {
                        text: "Series A",
                        style: {
                            color: "#FF1654"
                        }
                    }
                },
                {
                    opposite: true,
                    axisTicks: {
                        show: true
                    },
                    axisBorder: {
                        show: true,
                        color: "#247BA0"
                    },
                    labels: {
                        style: {
                            colors: "#247BA0"
                        }
                    },
                    title: {
                        text: "Series B",
                        style: {
                            color: "#247BA0"
                        }
                    }
                }
            ],
            tooltip: {
                shared: false,
                intersect: true,
                x: {
                    show: false
                }
            },
            legend: {
                horizontalAlign: "left",
                offsetX: 40
            }
        };

        var chart = new ApexCharts(document.querySelector("#line_chart"), options);

        chart.render();
    </script>
@endpush
