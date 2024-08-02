<x-filament::section>
    <x-slot name="heading">
        @if($this->user->is_superadmin)
            Appointments
        @else
            Patients
        @endif
    </x-slot>
    <div id="bar_chart"></div>
</x-filament::section>
<?php
    $super_admin = $this->user->is_superadmin;
    $monthly_data = array_fill(0, 12, 0);
    if($this->user->is_superadmin){
        foreach ($this->admin_data['appointments'] as $item) {
            $month = Carbon\Carbon::parse($item->created_at)->month;
            $monthly_data[$month - 1] += 1;
        }
    }else{
        foreach ($this->hospital_data['patients'] as $item) {
            $month = Carbon\Carbon::parse($item->created_at)->month;
            $monthly_data[$month - 1] += 1;
        }
    }
?>
@push('scripts')
    <script>

        var data_set = {!! json_encode($monthly_data) !!};
        var super_admin = {!! json_encode($super_admin) !!};
        
        var options = {
            chart: {
                height: 350,
                type: "bar",
                stacked: false
            },
            dataLabels: {
                enabled: false
            },
            colors: ["#FF1654"],
            series: [{
                    name: super_admin ? "Appointments" : "Patients",
                    data: data_set
                },
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
                        text: super_admin ? "Appointments" : "Patients",
                        style: {
                            color: "#FF1654"
                        }
                    }
                },
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

        var chart = new ApexCharts(document.querySelector("#bar_chart"), options);

        chart.render();
    </script>
@endpush
